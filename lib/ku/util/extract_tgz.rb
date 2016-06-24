require "rubygems/package"
require "zlib"

module Ku
  module Util
    module ExtractTgz
      TAR_LONGLINK = "././@LongLink".freeze

      def extract_tgz(file, destination = ".")
        Gem::Package::TarReader.new( Zlib::GzipReader.open file ) do |tar|
          dest = nil
          tar.each do |entry|
            if entry.full_name == TAR_LONGLINK
              dest = File.join destination, entry.read.strip
              next
            end
            dest ||= File.join destination, entry.full_name
            if entry.directory? || (entry.header.typeflag == "" && entry.full_name.end_with?("/"))
              File.delete dest if File.file? dest
              FileUtils.mkdir_p dest, mode: entry.header.mode, verbose: false
            elsif entry.file? || (entry.header.typeflag == "" && !entry.full_name.end_with?("/"))
              FileUtils.rm_rf dest if File.directory? dest
              File.open dest, "wb" do |f|
                f.print entry.read
              end
              FileUtils.chmod entry.header.mode, dest, verbose: false
            elsif entry.header.typeflag == "2" # Symlink!
              File.symlink entry.header.linkname, dest
              # puts "Unkown tar entry: #{entry.full_name} type: #{entry.header.typeflag}."
            end
            dest = nil
          end
        end
      end
    end
  end
end
