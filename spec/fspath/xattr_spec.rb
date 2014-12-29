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
          expect(FSPath(path).send(method)).to be_kind_of(Xattr)
        end

        it "should point to same path" do
          expect(FSPath(path).send(method).instance_variable_get(:@path)).to eq(path)
        end

        it "should set xattr on path" do
          expect(FSPath(file).lxattr['user.hello']).to be_nil
          expect(FSPath(link).lxattr['user.hello']).to be_nil

          FSPath(path).send(method)['user.hello'] = 'world'
          expect(FSPath(path).send(method)['user.hello']).to eq('world')

          if path == link && method == :lxattr
            expect(FSPath(file).lxattr['user.hello']).to be_nil
            expect(FSPath(link).lxattr['user.hello']).to eq('world')
          else
            expect(FSPath(file).lxattr['user.hello']).to eq('world')
            expect(FSPath(link).lxattr['user.hello']).to be_nil
          end
        end
      end
    end
  end
end
