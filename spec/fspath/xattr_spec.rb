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
    File.unlink(file)
    File.unlink(link)
  end

  def can_set_on_symlink?
    xxx = 'test'
    File.symlink('.', xxx)
    begin
      ::Xattr.new(xxx, :no_follow => true)['user.foo'] = 'bar'
      true
    rescue Errno::EPERM
      false
    ensure
      File.unlink(xxx)
    end
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
          on_symlink = path == link && method == :lxattr

          skip 'unsupported' if on_symlink && !can_set_on_symlink?

          expect(FSPath(file).lxattr['user.hello']).to be_nil
          expect(FSPath(link).lxattr['user.hello']).to be_nil

          FSPath(path).send(method)['user.hello'] = 'world'
          expect(FSPath(path).send(method)['user.hello']).to eq('world')

          if on_symlink
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
