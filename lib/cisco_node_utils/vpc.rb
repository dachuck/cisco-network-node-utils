# David Chuck, November 2015
#
# Copyright (c) 2014-2015 Cisco and/or its affiliates.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require_relative 'node_util'
require_relative 'interface'

# Add vpc-specific constants to Cisco namespace
module Cisco
  # Vpc - node utility class for VTP configuration management
  class Vpc < NodeUtil
    attr_reader :name
    # Constructor for Vpc
    def initialize(instantiate=true)
      enable if instantiate && !Vpc.enabled
    end

    def self.enabled
      !config_get('vpc', 'feature').nil?
    end

    def enable
      config_set('vpc', 'feature', '')
    end

    def destory
      config_set('vpc', 'feature', 'no')
    end

    ########################################################
    #                      PROPERTIES                      #
    ########################################################
    def domain
      enable ? config_get('vpc', 'domain') : ''
    end

    def domain=(d)
      fail ArgumentError unless d && d.is_a?(Integer)
      enable unless Vpc.enable
      begin
        config_set('vpc', 'domain', d)
      end
    end

    def system_priority
      config_get('vpc', 'system_priority')
    end

    def system_priority=(d)
      fail ArgumentError unless d && d.is_a?(Integer)
      enable unless Vpc.enable
      begin
        config_set('vpc', 'system_priority', d)
      end
    end

    def role_priority
      config_get('vpc', 'role_priority')
    end

    def role_priority=(d)
      fail ArgumentError unless d && d.is_a?(Integer)
      enable unless Vpc.enable
      begin
        config_set('vpc', 'role_priority', d)
      end
    end

    def delay_restore
      config_get('vpc', 'delay_restore')
    end

    def delay_restore=(d)
      fail ArgumentError unless d && d.is_a?(Integer)
      enable unless Vpc.enable
      begin
        config_set('vpc', 'delay_restore', d)
      end
    end

    def delay_restore_interface_vlan
      config_get('vpc', 'delay_restore_interface_vlan')
    end

    def delay_restore_interface_vlan=(d)
      fail ArgumentError unless d && d.is_a?(String)
      enable unless Vpc.enable
      begin
        config_set('vpc', 'delay_restore_interface_vlan', 'd')
      end
    end

    def peer_gateway
      config_get('vpc', 'peer_gateway')
    end

    def peer_getway=(no_cmd)
      fail TypeError unless no_cmd.is_a?(String)
      no_cmd.strip!
      return unless no_cmd.eql?('no' || '')
      if no_cmd.eql?('no')
        config_set('vpc', 'peer_gateway', state: 'no')
      else
        config_set('vpc', 'peer_gateway', state: '')
      end
    end
  end
end
