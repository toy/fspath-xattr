# fspath

Better than Pathname

### Extended attributes (using xattr gem)

Get extended attribute:

    FSPath('/a/b/c').xattr['com.macromates.caret']

Set extended attribute:

    FSPath('/a/b/c').xattr['good'] = 'bad'

Set extended attribute on symlink itself:

    FSPath('/a/b/c').lxattr['good'] = 'bad'

## Copyright

Copyright (c) 2010-2011 Ivan Kuchin. See LICENSE.txt for details.
