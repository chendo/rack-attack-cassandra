require "cassandra"

module Rack
  class Attack
    class Cassandra
      attr_reader :session

      TABLE_DEFINITION = <<-TABLE_CQL
        CREATE TABLE IF NOT EXISTS rack_attack_data (
          key VARCHAR,
          uuid TIMEUUID,
          PRIMARY KEY (key, uuid)
        )
      TABLE_CQL

      def initialize(session:)
        @session = session
        session.execute(TABLE_DEFINITION)
        @insert = session.prepare("INSERT INTO rack_attack_data (key, uuid) VALUES (?, NOW()) USING TTL ?")
        @select = session.prepare("SELECT COUNT(*) FROM rack_attack_data WHERE key = ?")
        @delete = session.prepare("DELETE FROM rack_attack_data WHERE key = ?")
      end

      def increment(key, value, expires_in: 60 * 60 * 24)
        raise ArgumentError, "value needs to be an Integer" unless value.is_a?(Integer)
        batch = session.batch do |batch|
          value.times { batch.add(@insert, key, expires_in) }
        end

        session.execute(batch, consistency: :one)
        read(key)
      end

      def read(key)
        session.execute(@select, key).each do |v|
          return v['count']
        end
      end

      def write(key, value, expires_in: 60 * 60 * 24)
        session.execute(@delete, key)
        increment(key, value, expires_in: expires_in)
      end
    end
  end
end