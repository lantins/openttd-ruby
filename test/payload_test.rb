require File.dirname(__FILE__) + '/test_helper'

class TestPayload < Test::Unit::TestCase
  def setup
    @packet = OpenTTD::Packet::TCP.new
  end

  def test_tcp_client_join_encode
    expected_binary = "\x17\x00\x021.0.0\x00test player\x00\xFF\x00"

    @packet.opcode = :tcp_client_join
    @packet.payload.client_version = '1.0.0'
    @packet.payload.player_name = 'test player'
    @packet.payload.company = 255
    @packet.payload.language = 0

    assert_equal expected_binary, @packet.to_binary_s
  end
  
  def test_tcp_server_need_password_decode
    packet_binary = ")\x00\a\x00d\xC2x\xED3fbe4f2e3c95b44f3fd31494e5f79c1d\x00"

    @packet.read(packet_binary)
    assert_equal packet_binary, @packet.to_binary_s

    assert_equal :tcp_server_need_password, @packet.opcode
    assert_equal :server, @packet.payload.password_type
    assert_equal 3984114276, @packet.payload.seed
    assert_equal '3fbe4f2e3c95b44f3fd31494e5f79c1d', @packet.payload.network_id
  end

  def test_tcp_client_password_encode
    expected_binary = "\r\x00\b\x00testpass\x00"

    @packet.opcode = :tcp_client_password
    @packet.payload.password_type = :server
    @packet.payload.password = 'testpass'

    assert_equal expected_binary, @packet.to_binary_s
  end

  def test_tcp_server_welcome_decode
    packet_binary = ",\x00\t\xDB\x02\x00\x00d\xC2x\xED3fbe4f2e3c95b44f3fd31494e5f79c1d\x00"

    @packet.read(packet_binary)
    assert_equal packet_binary, @packet.to_binary_s

    assert_equal :tcp_server_welcome, @packet.opcode
    assert_equal 731, @packet.payload.client_id
    assert_equal 3984114276, @packet.payload.seed
    assert_equal '3fbe4f2e3c95b44f3fd31494e5f79c1d', @packet.payload.network_id
  end

  def test_tcp_client_getmap_encode
    expected_binary = "\a\x00\nJL\b\x10"

    @packet.opcode = :tcp_client_getmap
    @packet.payload.version = 268979274

    assert_equal expected_binary, @packet.to_binary_s
  end

  def test_tcp_server_client_info_decode
    packet_binary = "\x0E\x00\x06\xDD\x02\x00\x00\xFFmaiow\x00"

    @packet.read(packet_binary)
    assert_equal packet_binary, @packet.to_binary_s

    assert_equal :tcp_server_client_info, @packet.opcode
    assert_equal 733, @packet.payload.client_id
    assert_equal 255, @packet.payload.company_id
    assert_equal 'maiow', @packet.payload.name
  end

  # end of the map data.
  def test_tcp_server_map_decode
    packet_binary = "\x04\x00\f\x02"

    @packet.read(packet_binary)
    assert_equal packet_binary, @packet.to_binary_s

    assert_equal :tcp_server_map, @packet.opcode
    assert_equal 2, @packet.payload.type
  end
  
  # let sever know we got the map ok.
  def test_tcp_client_map_ok_encode
    packet_binary = "\x03\x00\r"

    @packet.read(packet_binary)
    assert_equal packet_binary, @packet.to_binary_s

    assert_equal :tcp_client_map_ok, @packet.opcode
  end

  def test_tcp_server_frame_decode
    packet_binary = "\v\x00\x0F\xAC\x87_\x03\xAC\x87_\x03"

    @packet.read(packet_binary)
    assert_equal packet_binary, @packet.to_binary_s

    assert_equal :tcp_server_frame, @packet.opcode
    assert_equal 56592300, @packet.payload.frame_count
    assert_equal 56592300, @packet.payload.frame_count_max
    assert_equal '', @packet.payload.data
  end

  def test_tcp_server_sync_decode
    packet_binary = "\v\x00\x10\xAC\x87_\x03S:\x9B\xCB"

    @packet.read(packet_binary)
    assert_equal packet_binary, @packet.to_binary_s

    assert_equal :tcp_server_sync, @packet.opcode
    assert_equal 56592300, @packet.payload.frame
    assert_equal 3415947859, @packet.payload.seed
  end

  def test_tcp_server_join_decode
    packet_binary = "\a\x00\x0E\xDD\x02\x00\x00"

    @packet.read(packet_binary)
    assert_equal packet_binary, @packet.to_binary_s

    assert_equal :tcp_server_join, @packet.opcode
    assert_equal 733, @packet.payload.client_id
  end

  def test_tcp_server_config_update_decode
    packet_binary = "\x05\x00%\b\b"

    @packet.read(packet_binary)
    assert_equal packet_binary, @packet.to_binary_s

    assert_equal :tcp_server_config_update, @packet.opcode
    assert_equal 8, @packet.payload.max_companies
    assert_equal 8, @packet.payload.max_spectators
  end

  def test_tcp_server_company_update_decode
    packet_binary = "\x05\x00$\x00\x00"

    @packet.read(packet_binary)
    assert_equal packet_binary, @packet.to_binary_s

    assert_equal :tcp_server_company_update, @packet.opcode
    assert_equal 0, @packet.payload.passworded
  end

  def test_tcp_client_ack_encode
    expected_binary = "\a\x00\x11\xD0\x87_\x03"

    @packet.opcode = :tcp_client_ack
    @packet.payload.frame = 56592336

    assert_equal expected_binary, @packet.to_binary_s
  end
end