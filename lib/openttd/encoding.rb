module OpenTTD
    class Encoding < BinData::Record
        # will override getters and setters for fields.
        def self.override_getters_and_setters(fields, encoding)
            fields.each do |field|
                define_method field do
                    set_field_encoding_once(field, encoding)
                    decode(field)
                end
                
                define_method :"#{field}=" do |value|
                    set_field_encoding_once(field, encoding)
                    encode(field, value)
                end
            end
        end
        
        # fields are encoded/decoded using a lookup hash
        def self.lookup_encoding(*fields)
            override_getters_and_setters(fields, :lookup)
        end
        
        # fields are just booleans
        def self.boolean_encoding(*fields)
            override_getters_and_setters(fields, :boolean)
        end
        
        # fields are just to be converted to standard ruby counter-part.
        def self.no_encoding(*fields)
            override_getters_and_setters(fields, :no_encoding)
        end
        
        # fields are openttd style dates.
        def self.openttd_date(*fields)
            override_getters_and_setters(fields, :openttd_date)
        end
        
        # checks if the field uses any kind of encoding.
        def lookup_field_encoding(field)
            @encoding_map[field]
        end
        
        # set a field to use a type of encoding.
        def set_field_encoding_once(field, encoding)
            @encoding_map = Hash.new unless @encoding_map
            return false if @encoding_map[field]
            @encoding_map[field] = encoding
        end
        
        # main encode method.
        def encode(field, value)
            obj = find_obj_for_name(field)
            
            # does this field use encoding?
            encoding = lookup_field_encoding(field)
            unless encoding
                # we dont use encoding, set the raw value.
                obj.assign(value)
                return true
            end
            
            # we do use encoding.
            value = case encoding
                when :lookup
                    v = encodeing_lookup_map[field].select { |k,v| v == value }.collect { |a| a[0] }.first
                    raise StandardError, "unknown value for attribute: #{field}" unless v
                    v
                when :boolean
                    value == true ? 1 : 0
                when :no_encoding, :openttd_date
                    value
                else
                    raise StandardError, "don't know how to deal with #{encoding} encoding."
            end
            
            obj.assign(value)
            return true
        end
        
        # main decode method.
        def decode(field)
            obj = find_obj_for_name(field)
            
            encoding = lookup_field_encoding(field)
            case encoding
                when :lookup
                    encodeing_lookup_map[field][obj] || nil
                when :boolean
                    obj == 1 ? true : false
                when :openttd_date
                    Date.new(0, 1, 1, Date::GREGORIAN) + obj.value
                when :no_encoding
                    obj.snapshot
                else
                    raise StandardError, "don't know how to deal with #{encoding} encoding."
            end
        end
        
        # create hash snapshot of the data.
        def snapshot
            snapshot = Snapshot.new
            field_names.each do |field|
                obj = find_obj_for_name(field)
                next unless include_obj(obj) # if the field is hidden, skip to the next.
                snap = self.send(field.to_sym)
                if snap.kind_of?(BinData::Base)
                    snapshot[field] = obj.snapshot
                else
                    snapshot[field] = snap
                end
            end
            snapshot
        end
    end
end