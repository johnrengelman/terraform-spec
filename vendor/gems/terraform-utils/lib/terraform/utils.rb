require "terraform/utils/version"
require 'json'
require 'ostruct'

module Terraform
  module Utils
    def loadState(path)
      StateReader.new(path)
    end

    module_function :loadState

    class StateReader
      attr_accessor :path, :state
      def initialize(path)
        @path = path
        @state = JSON.parse(File.read(path), object_class: OpenStruct)
      end

      def root
        submodule(["root"])
      end

      def submodule(name)
        @state.modules.select { |mod| mod.path == name }.first
      end
    end

  end
end
