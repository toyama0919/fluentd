#
# Fluentd
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#

require 'fluent/engine'

module Fluent
  module PluginSupport
    module Emitter
      attr_accessor :router

      def initialize
        super
        @router = nil
      end

      def configure(conf)
        super

        if label_name = conf['@label']
          label = Engine.root_agent.find_label(label_name)
          @router = label.event_router
        elsif @router.nil?
          @router = Engine.root_agent.event_router
        end
      end

      def emits?
        true
      end

      def shutdown
        super

        # TODO: disable @router
      end
    end
  end
end

