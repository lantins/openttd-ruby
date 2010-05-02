$:.unshift(File.expand_path(File.dirname(__FILE__))) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'payload/tcp_client'
require 'payload/tcp_server'
require 'payload/udp_client'
require 'payload/udp_server'

module OpenTTD
    ##
    # Payloads are part of a packet, they offer a 'high level' view of the
    # binary data.
    #
    # - TcpServer & UdpServer  server to client
    # - TcpClient & UdpClient  client to server
    module Payload
        
        ##
        # @private
        # An empty payload, only the opcode of the packet is used.
        class Empty < OpenTTD::Encoding; end
        
        class TcpServerFull < Empty; end # the server is full, mayhaps try again later?
        class TcpServerBanned < Empty; end # your banned from the server, oh noes.
        
        class TcpClientCompanyInfo < Empty; end
        class TcpClientNewgrfsChecked < Empty; end
        class TcpClientMapOk < Empty; end
        class TcpClientQuit < Empty; end
        
        class TcpServerShutdown < Empty; end
        class TcpServerNewgame < Empty; end
        
        class UdpClientDetailInfo < Empty; end # companies on the server.
        class UdpClientFindServer < Empty; end # server details/settings.
        
        CHAT_ENCODING_MAP = {
            :action_id => {
                0 => :join,
                1 => :leave,
                2 => :server_message,
                3 => :chat,
                4 => :chat_company,
                5 => :chat_client,
                6 => :give_money,
                7 => :name_change,
                8 => :company_spectator,
                9 => :company_join,
                10 => :company_new
            },
            :type_id => {
                0 => :broadcast,
                1 => :team,
                2 => :private
            }
        }
        
        ERROR_ENCODING_MAP = {
            :error_code => {
                0 => :general,
                1 => :desync,
                2 => :savegame_failed,
                3 => :connection_lost,
                4 => :illegal_packet,
                5 => :newgrf_mismatch,
                6 => :not_authorized,
                7 => :not_expected,
                8 => :wrong_revision,
                9 => :name_in_use,
                10 => :wrong_password,
                11 => :player_mismatch,
                12 => :kicked,
                13 => :cheater,
                14 => :full
            }
        }
        
        PASSWORD_TYPE_ENCODING_MAP = {
            :password_type => {
                0 => :server,
                1 => :company
            }
        }
        
        COMMAND_ENCODING_MAP = {
            :command => {
                    0 => :cmd_build_railroad_track,         #build a rail track
                    1 => :cmd_remove_railroad_track,        #remove a rail track
                    2 => :cmd_build_single_rail,            #build a single rail track
                    3 => :cmd_remove_single_rail,           #remove a single rail track
                    4 => :cmd_landscape_clear,              #demolish a tile
                    5 => :cmd_build_bridge,                 #build a bridge
                    6 => :cmd_build_rail_station,           #build a rail station
                    7 => :cmd_build_train_depot,            #build a train depot
                    8 => :cmd_build_signals,                #build a signal
                    9 => :cmd_remove_signals,               #remove a signal
                    10 => :cmd_terraform_land,               #terraform a tile
                    11 => :cmd_purchase_land_area,           #purchase a tile
                    12 => :cmd_sell_land_area,               #sell a bought tile before
                    13 => :cmd_build_tunnel,                 #build a tunnel
                    14 => :cmd_remove_from_rail_station,     #remove a (rectangle of) tiles from a rail station
                    15 => :cmd_convert_rail,                 #convert a rail type
                    16 => :cmd_build_rail_waypoint,          #build a waypoint
                    17 => :cmd_rename_waypoint,              #rename a waypoint
                    18 => :cmd_remove_from_rail_waypoint,    #remove a (rectangle of) tiles from a rail waypoint
                    19 => :cmd_build_road_stop,              #build a road stop
                    20 => :cmd_remove_road_stop,             #remove a road stop
                    21 => :cmd_build_long_road,              #build a complete road (not a "half" one)
                    22 => :cmd_remove_long_road,             #remove a complete road (not a "half" one)
                    23 => :cmd_build_road,                   #build a "half" road
                    24 => :cmd_build_road_depot,             #build a road depot
                    25 => :cmd_build_airport,                #build an airport
                    26 => :cmd_build_dock,                   #build a dock
                    27 => :cmd_build_ship_depot,             #build a ship depot
                    28 => :cmd_build_buoy,                   #build a buoy
                    29 => :cmd_plant_tree,                   #plant a tree
                    30 => :cmd_build_rail_vehicle,           #build a rail vehicle
                    31 => :cmd_move_rail_vehicle,            #move a rail vehicle (in the depot)
                    32 => :cmd_sell_rail_wagon,              #sell a rail wagon
                    33 => :cmd_send_train_to_depot,          #send a train to a depot
                    34 => :cmd_force_train_proceed,          #proceed a train to pass a red signal
                    35 => :cmd_reverse_train_direction,      #turn a train around
                    36 => :cmd_modify_order,                 #modify an order (like set full-load)
                    37 => :cmd_skip_to_order,                #skip an order to the next of specific one
                    38 => :cmd_delete_order,                 #delete an order
                    39 => :cmd_insert_order,                 #insert a new order
                    40 => :cmd_change_service_int,           #change the server interval of a vehicle
                    41 => :cmd_build_industry,               #build a new industry
                    42 => :cmd_build_company_hq,             #build the company headquarter
                    43 => :cmd_set_company_manager_face,     #set the manager's face of the company
                    44 => :cmd_set_company_colour,            #set the colour of the company
                    45 => :cmd_increase_loan,                #increase the loan from the bank
                    46 => :cmd_decrease_loan,                #decrease the loan from the bank
                    47 => :cmd_want_engine_preview,          #confirm the preview of an engine
                    48 => :cmd_rename_vehicle,               #rename a whole vehicle
                    49 => :cmd_rename_engine,                #rename a engine (in the engine list)
                    50 => :cmd_rename_company,               #change the company name
                    51 => :cmd_rename_president,             #change the president name
                    52 => :cmd_rename_station,               #rename a station
                    53 => :cmd_sell_aircraft,                #sell an aircraft
                    54 => :cmd_build_aircraft,               #build an aircraft
                    55 => :cmd_send_aircraft_to_hangar,      #send an aircraft to a hanger
                    56 => :cmd_refit_aircraft,               #refit the cargo space of an aircraft
                    57 => :cmd_place_sign,                   #place a sign
                    58 => :cmd_rename_sign,                  #rename a sign
                    59 => :cmd_build_road_veh,               #build a road vehicle
                    60 => :cmd_sell_road_veh,                #sell a road vehicle
                    61 => :cmd_send_roadveh_to_depot,        #send a road vehicle to the depot
                    62 => :cmd_turn_roadveh,                 #turn a road vehicle around
                    63 => :cmd_refit_road_veh,               #refit the cargo space of a road vehicle
                    64 => :cmd_pause,                        #pause the game
                    65 => :cmd_buy_share_in_company,         #buy a share from a company
                    66 => :cmd_sell_share_in_company,        #sell a share from a company
                    67 => :cmd_buy_company,                  #buy a company which is bankrupt
                    68 => :cmd_found_town,                   #found a town
                    69 => :cmd_rename_town,                  #rename a town
                    70 => :cmd_do_town_action,               #do a action from the town detail window (like advertises or bribe)
                    71 => :cmd_sell_ship,                    #sell a ship
                    72 => :cmd_build_ship,                   #build a new ship
                    73 => :cmd_send_ship_to_depot,           #send a ship to a depot
                    74 => :cmd_refit_ship,                   #refit the cargo space of a ship
                    75 => :cmd_order_refit,                  #change the refit informaction of an order (for "goto depot" )
                    76 => :cmd_clone_order,                  #clone (and share) an order
                    77 => :cmd_clear_area,                   #clear an area
                    78 => :cmd_money_cheat,                  #do the money cheat
                    79 => :cmd_build_canal,                  #build a canal
                    80 => :cmd_company_ctrl,                 #used in multiplayer to create a new companies etc.
                    81 => :cmd_level_land,                   #level land
                    82 => :cmd_refit_rail_vehicle,           #refit the cargo space of a train
                    83 => :cmd_restore_order_index,          #restore vehicle order-index and service interval
                    84 => :cmd_build_lock,                   #build a lock
                    85 => :cmd_build_signal_track,           #add signals along a track (by dragging)
                    86 => :cmd_remove_signal_track,          #remove signals along a track (by dragging)
                    87 => :cmd_give_money,                   #give money to another company
                    88 => :cmd_change_setting,               #change a setting
                    89 => :cmd_change_company_setting,       #change a company etting
                    90 => :cmd_set_autoreplace,              #set an autoreplace entry
                    91 => :cmd_clone_vehicle,                #clone a vehicle
                    92 => :cmd_start_stop_vehicle,           #start or stop a vehicle
                    93 => :cmd_mass_start_stop,              #start/stop all vehicles (in a depot)
                    94 => :cmd_autoreplace_vehicle,          #replace/renew a vehicle while it is in a depot
                    95 => :cmd_depot_sell_all_vehicles,      #sell all vehicles which are in a given depot
                    96 => :cmd_depot_mass_autoreplace,       #force the autoreplace to take action in a given depot
                    97 => :cmd_create_group,                 #create a new group
                    98 => :cmd_delete_group,                 #delete a group
                    99 => :cmd_rename_group,                 #rename a group
                    100 => :cmd_add_vehicle_group,            #add a vehicle to a group
                    101 => :cmd_add_shared_vehicle_group,     #add all other shared vehicles to a group which are missing
                    102 => :cmd_remove_all_vehicles_group,    #remove all vehicles from a group
                    103 => :cmd_set_group_replace_protection, #set the autoreplace-protection for a group
                    104 => :cmd_move_order,                   #move an order
                    105 => :cmd_change_timetable,             #change the timetable for a vehicle
                    106 => :cmd_set_vehicle_on_time,          #set the vehicle on time feature (timetable)
                    107 => :cmd_autofill_timetable,           #autofill the timetable
                    108 => :cmd_set_timetable_start          #set the date that a timetable should start
            }
        }
    end
end