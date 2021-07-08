# fspath

Better than Pathname

[![Build Status](https://img.shields.io/github/workflow/status/toy/fspath-xattr/check/master?logo=github)](https://github.com/toy/fspath-xattr/actions/workflows/check.yml)

### Extended attributes (using xattr gem)

Get extended attribute:

    FSPath('/a/b/c').xattr['com.macromates.caret']

Set extended attribute:

    FSPath('/a/b/c').xattr['good'] = 'bad'

Set extended attribute on symlink itself:

    FSPath('/a/b/c').lxattr['good'] = 'bad'

## Copyright

Copyright (c) 2010-2019 Ivan Kuchin. See LICENSE.txt for details.
