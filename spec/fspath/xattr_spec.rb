require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'fspath/xattr'

describe FSPath::Xattr do
  file = 'file'
  link = 'link'

  before do
    File.open(file, 'w'){ |io| io << 'some content' }
    File.symlink(file, link)
  end
  after do
    File.delete(file)
    File.delete(link)
  end

  describe "xattr" do
    [
      [file, :xattr],
      [link, :xattr],
      [file, :lxattr],
      [link, :lxattr],
    ].each do |path, method|
      describe "#{path}.#{method}" do
        it "should return instance of Xattr" do
          FSPath(path).send(method).should be_kind_of(Xattr)
        end

        it "should point to same path" do
          FSPath(path).send(method).instance_variable_get(:@path).should == path
        end

        it "should set xattr on path" do
          FSPath(file).lxattr['user.hello'].should be_nil
          FSPath(link).lxattr['user.hello'].should be_nil

          FSPath(path).send(method)['user.hello'] = 'world'
          FSPath(path).send(method)['user.hello'].should == 'world'

          if path == link && method == :lxattr
            FSPath(file).lxattr['user.hello'].should be_nil
            FSPath(link).lxattr['user.hello'].should == 'world'
          else
            FSPath(file).lxattr['user.hello'].should == 'world'
            FSPath(link).lxattr['user.hello'].should be_nil
          end
        end
      end
    end
  end
end
