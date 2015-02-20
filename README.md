# Nokogiri Segfault

This crashes on our a little bit outdated CentOS system. I could not reproduce it on a Debian Wheezy.

Earliest version that crashes is 1.6.2.rc1, up to latest 1.6.6.2.

Stack trace says [this line](https://github.com/sparklemotion/nokogiri/blob/v1.6.6.2/ext/nokogiri/xml_node.c#L831) causes the segmentation fault.

## System

### uname -a

```
Linux systemx.flavoursys.lan 3.18.3 #2 SMP Thu Jan 22 14:56:25 CET 2015 x86_64 x86_64 x86_64 GNU/Linux
```

### ruby -v

```
ruby 2.1.2p95 (2014-05-08 revision 45877) [x86_64-linux]
```

### nokogiri -v

```
# Nokogiri (1.6.6.2)
    ---
    warnings: []
    nokogiri: 1.6.6.2
    ruby:
      version: 2.1.2
      platform: x86_64-linux
      description: ruby 2.1.2p95 (2014-05-08 revision 45877) [x86_64-linux]
      engine: ruby
    libxml:
      binding: extension
      source: packaged
      libxml2_path: "/opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/ports/x86_64-unknown-linux-gnu/libxml2/2.9.2"
      libxslt_path: "/opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/ports/x86_64-unknown-linux-gnu/libxslt/1.1.28"
      libxml2_patches:
      - 0001-Revert-Missing-initialization-for-the-catalog-module.patch
      - 0002-Fix-missing-entities-after-CVE-2014-3660-fix.patch
      libxslt_patches:
      - 0001-Adding-doc-update-related-to-1.1.28.patch
      - 0002-Fix-a-couple-of-places-where-f-printf-parameters-wer.patch
      - 0003-Initialize-pseudo-random-number-generator-with-curre.patch
      - 0004-EXSLT-function-str-replace-is-broken-as-is.patch
      - 0006-Fix-str-padding-to-work-with-UTF-8-strings.patch
      - 0007-Separate-function-for-predicate-matching-in-patterns.patch
      - 0008-Fix-direct-pattern-matching.patch
      - 0009-Fix-certain-patterns-with-predicates.patch
      - 0010-Fix-handling-of-UTF-8-strings-in-EXSLT-crypto-module.patch
      - 0013-Memory-leak-in-xsltCompileIdKeyPattern-error-path.patch
      - 0014-Fix-for-bug-436589.patch
      - 0015-Fix-mkdir-for-mingw.patch
      compiled: 2.9.2
      loaded: 2.9.2
```

### Ruby Segfault output (with 1.6.6.2)

```
/opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/node.rb:104: [BUG] Segmentation fault at 0xfffffffff63e4c00
ruby 2.1.2p95 (2014-05-08 revision 45877) [x86_64-linux]

-- Control frame information -----------------------------------------------
c:0008 p:---- s:0028 e:000027 CFUNC  :get
c:0007 p:0011 s:0024 e:000023 METHOD /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/node.rb:104
c:0006 p:0011 s:0020 e:000018 BLOCK  test.rb:6
c:0005 p:0011 s:0016 e:000015 BLOCK  /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/node_set.rb:187 [FINISH]
c:0004 p:---- s:0013 e:000012 CFUNC  :upto
c:0003 p:0013 s:0009 e:000008 METHOD /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/node_set.rb:186
c:0002 p:0042 s:0005 E:001020 EVAL   test.rb:5 [FINISH]
c:0001 p:0000 s:0002 E:0007b8 TOP    [FINISH]

test.rb:5:in `<main>'
/opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/node_set.rb:186:in `each'
/opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/node_set.rb:186:in `upto'
/opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/node_set.rb:187:in `block in each'
test.rb:6:in `block in <main>'
/opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/node.rb:104:in `[]'
/opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/node.rb:104:in `get'

-- C level backtrace information -------------------------------------------
ruby(+0x1682ea) [0x7f27f3f732ea]
ruby(+0x1c8eb8) [0x7f27f3fd3eb8]
ruby(rb_bug+0xce) [0x7f27f3fd41ee]
ruby(+0xe5121) [0x7f27f3ef0121]
/lib64/libpthread.so.0(+0x3f5dc0f710) [0x7f27f39db710]
/lib64/libc.so.6(+0x3f5d87f96a) [0x7f27f2df096a]
/opt/local/lib/ruby/gems/2.1.0/extensions/x86_64-linux/2.1.0-static/nokogiri-1.6.6.2/nokogiri/nokogiri.so(+0x41afd) [0x7f27e8f87afd] xml_node.c:831
ruby(+0x150572) [0x7f27f3f5b572]
ruby(+0x1669d1) [0x7f27f3f719d1]
ruby(+0x15c3ee) [0x7f27f3f673ee]
ruby(+0x161e4b) [0x7f27f3f6ce4b]
ruby(rb_yield+0x74) [0x7f27f3f6edd4]
ruby(+0x6b411) [0x7f27f3e76411]
ruby(+0x150572) [0x7f27f3f5b572]
ruby(+0x1669d1) [0x7f27f3f719d1]
ruby(+0x15d171) [0x7f27f3f68171]
ruby(+0x161e4b) [0x7f27f3f6ce4b]
ruby(rb_iseq_eval_main+0x300) [0x7f27f3f6d430]
ruby(+0x237bd) [0x7f27f3e2e7bd]
ruby(ruby_run_node+0x37) [0x7f27f3e304a7]
ruby(+0x21cac) [0x7f27f3e2ccac]
/lib64/libc.so.6(__libc_start_main+0xfd) [0x7f27f2d8fd1d]
ruby(+0x21b89) [0x7f27f3e2cb89]

-- Other runtime information -----------------------------------------------

* Loaded script: test.rb

* Loaded features:

    0 enumerator.so
    1 /opt/local/lib/ruby/2.1.0/x86_64-linux/enc/encdb.so
    2 /opt/local/lib/ruby/2.1.0/x86_64-linux/enc/trans/transdb.so
    3 /opt/local/lib/ruby/2.1.0/x86_64-linux/rbconfig.rb
    4 /opt/local/lib/ruby/2.1.0/rubygems/compatibility.rb
    5 /opt/local/lib/ruby/2.1.0/rubygems/defaults.rb
    6 /opt/local/lib/ruby/2.1.0/rubygems/deprecate.rb
    7 /opt/local/lib/ruby/2.1.0/rubygems/errors.rb
    8 /opt/local/lib/ruby/2.1.0/rubygems/version.rb
    9 /opt/local/lib/ruby/2.1.0/rubygems/requirement.rb
   10 /opt/local/lib/ruby/2.1.0/rubygems/platform.rb
   11 /opt/local/lib/ruby/2.1.0/rubygems/basic_specification.rb
   12 /opt/local/lib/ruby/2.1.0/rubygems/stub_specification.rb
   13 /opt/local/lib/ruby/2.1.0/rubygems/util/stringio.rb
   14 /opt/local/lib/ruby/2.1.0/rubygems/specification.rb
   15 /opt/local/lib/ruby/2.1.0/rubygems/exceptions.rb
   16 /opt/local/lib/ruby/2.1.0/rubygems/core_ext/kernel_gem.rb
   17 thread.rb
   18 /opt/local/lib/ruby/2.1.0/x86_64-linux/thread.so
   19 /opt/local/lib/ruby/2.1.0/monitor.rb
   20 /opt/local/lib/ruby/2.1.0/rubygems/core_ext/kernel_require.rb
   21 /opt/local/lib/ruby/2.1.0/rubygems.rb
   22 /opt/local/lib/ruby/2.1.0/x86_64-linux/pathname.so
   23 /opt/local/lib/ruby/2.1.0/pathname.rb
   24 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/constants.rb
   25 /opt/local/lib/ruby/2.1.0/rubygems/dependency.rb
   26 /opt/local/lib/ruby/2.1.0/rubygems/path_support.rb
   27 /opt/local/lib/ruby/2.1.0/x86_64-linux/io/console.so
   28 /opt/local/lib/ruby/2.1.0/rubygems/user_interaction.rb
   29 /opt/local/lib/ruby/2.1.0/x86_64-linux/etc.so
   30 /opt/local/lib/ruby/2.1.0/rubygems/config_file.rb
   31 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/rubygems_integration.rb
   32 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/current_ruby.rb
   33 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/shared_helpers.rb
   34 /opt/local/lib/ruby/2.1.0/fileutils.rb
   35 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/gem_path_manipulation.rb
   36 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/gem_helpers.rb
   37 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/match_platform.rb
   38 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/rubygems_ext.rb
   39 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/version.rb
   40 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler.rb
   41 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/settings.rb
   42 /opt/local/lib/ruby/2.1.0/x86_64-linux/digest.so
   43 /opt/local/lib/ruby/2.1.0/digest.rb
   44 /opt/local/lib/ruby/2.1.0/x86_64-linux/digest/sha1.so
   45 /opt/local/lib/ruby/2.1.0/set.rb
   46 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/definition.rb
   47 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/dependency.rb
   48 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/ruby_dsl.rb
   49 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/dsl.rb
   50 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/source.rb
   51 /opt/local/lib/ruby/2.1.0/uri/common.rb
   52 /opt/local/lib/ruby/2.1.0/uri/generic.rb
   53 /opt/local/lib/ruby/2.1.0/uri/ftp.rb
   54 /opt/local/lib/ruby/2.1.0/uri/http.rb
   55 /opt/local/lib/ruby/2.1.0/uri/https.rb
   56 /opt/local/lib/ruby/2.1.0/uri/ldap.rb
   57 /opt/local/lib/ruby/2.1.0/uri/ldaps.rb
   58 /opt/local/lib/ruby/2.1.0/uri/mailto.rb
   59 /opt/local/lib/ruby/2.1.0/uri.rb
   60 /opt/local/lib/ruby/2.1.0/x86_64-linux/socket.so
   61 /opt/local/lib/ruby/2.1.0/socket.rb
   62 /opt/local/lib/ruby/2.1.0/timeout.rb
   63 /opt/local/lib/ruby/2.1.0/net/protocol.rb
   64 /opt/local/lib/ruby/2.1.0/x86_64-linux/zlib.so
   65 /opt/local/lib/ruby/2.1.0/x86_64-linux/stringio.so
   66 /opt/local/lib/ruby/2.1.0/net/http/exceptions.rb
   67 /opt/local/lib/ruby/2.1.0/net/http/header.rb
   68 /opt/local/lib/ruby/2.1.0/net/http/generic_request.rb
   69 /opt/local/lib/ruby/2.1.0/net/http/request.rb
   70 /opt/local/lib/ruby/2.1.0/net/http/requests.rb
   71 /opt/local/lib/ruby/2.1.0/net/http/response.rb
   72 /opt/local/lib/ruby/2.1.0/net/http/responses.rb
   73 /opt/local/lib/ruby/2.1.0/net/http/proxy_delta.rb
   74 /opt/local/lib/ruby/2.1.0/net/http/backward.rb
   75 /opt/local/lib/ruby/2.1.0/net/http.rb
   76 /opt/local/lib/ruby/2.1.0/x86_64-linux/date_core.so
   77 /opt/local/lib/ruby/2.1.0/date/format.rb
   78 /opt/local/lib/ruby/2.1.0/date.rb
   79 /opt/local/lib/ruby/2.1.0/time.rb
   80 /opt/local/lib/ruby/2.1.0/rubygems/request.rb
   81 /opt/local/lib/ruby/2.1.0/cgi/core.rb
   82 /opt/local/lib/ruby/2.1.0/cgi/util.rb
   83 /opt/local/lib/ruby/2.1.0/cgi/cookie.rb
   84 /opt/local/lib/ruby/2.1.0/cgi.rb
   85 /opt/local/lib/ruby/2.1.0/rubygems/uri_formatter.rb
   86 /opt/local/lib/ruby/2.1.0/x86_64-linux/fcntl.so
   87 /opt/local/lib/ruby/2.1.0/x86_64-linux/openssl.so
   88 /opt/local/lib/ruby/2.1.0/openssl/bn.rb
   89 /opt/local/lib/ruby/2.1.0/openssl/cipher.rb
   90 /opt/local/lib/ruby/2.1.0/openssl/config.rb
   91 /opt/local/lib/ruby/2.1.0/openssl/digest.rb
   92 /opt/local/lib/ruby/2.1.0/openssl/x509.rb
   93 /opt/local/lib/ruby/2.1.0/openssl/buffering.rb
   94 /opt/local/lib/ruby/2.1.0/openssl/ssl.rb
   95 /opt/local/lib/ruby/2.1.0/openssl.rb
   96 /opt/local/lib/ruby/2.1.0/securerandom.rb
   97 /opt/local/lib/ruby/2.1.0/resolv.rb
   98 /opt/local/lib/ruby/2.1.0/rubygems/remote_fetcher.rb
   99 /opt/local/lib/ruby/2.1.0/rubygems/text.rb
  100 /opt/local/lib/ruby/2.1.0/rubygems/name_tuple.rb
  101 /opt/local/lib/ruby/2.1.0/rubygems/spec_fetcher.rb
  102 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/source/rubygems.rb
  103 /opt/local/lib/ruby/2.1.0/x86_64-linux/strscan.so
  104 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/source/path.rb
  105 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/source/git.rb
  106 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/lockfile_parser.rb
  107 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/lazy_specification.rb
  108 /opt/local/lib/ruby/2.1.0/tsort.rb
  109 /opt/local/lib/ruby/2.1.0/forwardable.rb
  110 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/spec_set.rb
  111 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/environment.rb
  112 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/runtime.rb
  113 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/index.rb
  114 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/remote_specification.rb
  115 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/endpoint_specification.rb
  116 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/dep_proxy.rb
  117 /opt/local/lib/ruby/gems/2.1.0/gems/bundler-1.6.5/lib/bundler/setup.rb
  118 /opt/local/lib/ruby/gems/2.1.0/extensions/x86_64-linux/2.1.0-static/nokogiri-1.6.6.2/nokogiri/nokogiri.so
  119 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/version.rb
  120 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/syntax_error.rb
  121 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/pp/node.rb
  122 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/pp/character_data.rb
  123 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/pp.rb
  124 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/parse_options.rb
  125 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/sax/document.rb
  126 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/sax/parser_context.rb
  127 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/sax/parser.rb
  128 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/sax/push_parser.rb
  129 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/sax.rb
  130 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/searchable.rb
  131 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/node/save_options.rb
  132 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/node.rb
  133 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/attribute_decl.rb
  134 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/element_decl.rb
  135 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/element_content.rb
  136 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/character_data.rb
  137 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/namespace.rb
  138 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/attr.rb
  139 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/dtd.rb
  140 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/cdata.rb
  141 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/text.rb
  142 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/document.rb
  143 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/document_fragment.rb
  144 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/processing_instruction.rb
  145 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/node_set.rb
  146 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/syntax_error.rb
  147 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/xpath/syntax_error.rb
  148 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/xpath.rb
  149 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/xpath_context.rb
  150 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/builder.rb
  151 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/reader.rb
  152 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/notation.rb
  153 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/entity_decl.rb
  154 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/schema.rb
  155 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/relax_ng.rb
  156 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml.rb
  157 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xslt/stylesheet.rb
  158 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xslt.rb
  159 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/html/entity_lookup.rb
  160 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/html/document.rb
  161 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/html/document_fragment.rb
  162 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/html/sax/parser_context.rb
  163 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/html/sax/parser.rb
  164 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/html/sax/push_parser.rb
  165 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/html/element_description.rb
  166 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/html/element_description_defaults.rb
  167 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/html.rb
  168 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/decorators/slop.rb
  169 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/css/node.rb
  170 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/css/xpath_visitor.rb
  171 /opt/local/lib/ruby/2.1.0/x86_64-linux/racc/cparse.so
  172 /opt/local/lib/ruby/2.1.0/racc/parser.rb
  173 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/css/parser_extras.rb
  174 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/css/parser.rb
  175 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/css/tokenizer.rb
  176 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/css/syntax_error.rb
  177 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/css.rb
  178 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri/html/builder.rb
  179 /opt/local/lib/ruby/gems/2.1.0/gems/nokogiri-1.6.6.2/lib/nokogiri.rb

* Process memory map:

7f27e887f000-7f27e8895000 r-xp 00000000 fd:00 3026501                    /lib64/libgcc_s-4.4.7-20120601.so.1
7f27e8895000-7f27e8a94000 ---p 00016000 fd:00 3026501                    /lib64/libgcc_s-4.4.7-20120601.so.1
7f27e8a94000-7f27e8a95000 rw-p 00015000 fd:00 3026501                    /lib64/libgcc_s-4.4.7-20120601.so.1
7f27e8a95000-7f27e8b2a000 rw-p 00000000 00:00 0 
7f27e8b2a000-7f27e8b41000 r-xp 00000000 fd:00 2098195                    /usr/lib64/gconv/CP932.so
7f27e8b41000-7f27e8d40000 ---p 00017000 fd:00 2098195                    /usr/lib64/gconv/CP932.so
7f27e8d40000-7f27e8d41000 r--p 00016000 fd:00 2098195                    /usr/lib64/gconv/CP932.so
7f27e8d41000-7f27e8d42000 rw-p 00017000 fd:00 2098195                    /usr/lib64/gconv/CP932.so
7f27e8d42000-7f27e8d46000 r-xp 00000000 fd:00 1464325                    /opt/local/lib/ruby/2.1.0/x86_64-linux/racc/cparse.so
7f27e8d46000-7f27e8f45000 ---p 00004000 fd:00 1464325                    /opt/local/lib/ruby/2.1.0/x86_64-linux/racc/cparse.so
7f27e8f45000-7f27e8f46000 rw-p 00003000 fd:00 1464325                    /opt/local/lib/ruby/2.1.0/x86_64-linux/racc/cparse.so
7f27e8f46000-7f27e916d000 r-xp 00000000 fd:00 3162528                    /opt/local/lib/ruby/gems/2.1.0/extensions/x86_64-linux/2.1.0-static/nokogiri-1.6.6.2/nokogiri/nokogiri.so
7f27e916d000-7f27e936d000 ---p 00227000 fd:00 3162528                    /opt/local/lib/ruby/gems/2.1.0/extensions/x86_64-linux/2.1.0-static/nokogiri-1.6.6.2/nokogiri/nokogiri.so
7f27e936d000-7f27e9379000 rw-p 00227000 fd:00 3162528                    /opt/local/lib/ruby/gems/2.1.0/extensions/x86_64-linux/2.1.0-static/nokogiri-1.6.6.2/nokogiri/nokogiri.so
7f27e9379000-7f27e937b000 rw-p 00000000 00:00 0 
7f27e937b000-7f27e9380000 r-xp 00000000 fd:00 1464349                    /opt/local/lib/ruby/2.1.0/x86_64-linux/strscan.so
7f27e9380000-7f27e9580000 ---p 00005000 fd:00 1464349                    /opt/local/lib/ruby/2.1.0/x86_64-linux/strscan.so
7f27e9580000-7f27e9581000 rw-p 00005000 fd:00 1464349                    /opt/local/lib/ruby/2.1.0/x86_64-linux/strscan.so
7f27e9581000-7f27e95d2000 r-xp 00000000 fd:00 1464327                    /opt/local/lib/ruby/2.1.0/x86_64-linux/openssl.so
7f27e95d2000-7f27e97d1000 ---p 00051000 fd:00 1464327                    /opt/local/lib/ruby/2.1.0/x86_64-linux/openssl.so
7f27e97d1000-7f27e97d4000 rw-p 00050000 fd:00 1464327                    /opt/local/lib/ruby/2.1.0/x86_64-linux/openssl.so
7f27e97d4000-7f27e97d5000 rw-p 00000000 00:00 0 
7f27e97d5000-7f27e97d6000 r-xp 00000000 fd:00 1464346                    /opt/local/lib/ruby/2.1.0/x86_64-linux/fcntl.so
7f27e97d6000-7f27e99d5000 ---p 00001000 fd:00 1464346                    /opt/local/lib/ruby/2.1.0/x86_64-linux/fcntl.so
7f27e99d5000-7f27e99d6000 rw-p 00000000 fd:00 1464346                    /opt/local/lib/ruby/2.1.0/x86_64-linux/fcntl.so
7f27e99d6000-7f27e9a0a000 r-xp 00000000 fd:00 1464357                    /opt/local/lib/ruby/2.1.0/x86_64-linux/date_core.so
7f27e9a0a000-7f27e9c0a000 ---p 00034000 fd:00 1464357                    /opt/local/lib/ruby/2.1.0/x86_64-linux/date_core.so
7f27e9c0a000-7f27e9c0c000 rw-p 00034000 fd:00 1464357                    /opt/local/lib/ruby/2.1.0/x86_64-linux/date_core.so
7f27e9c0c000-7f27e9c0d000 rw-p 00000000 00:00 0 
7f27e9c0d000-7f27e9c14000 r-xp 00000000 fd:00 1464334                    /opt/local/lib/ruby/2.1.0/x86_64-linux/stringio.so
7f27e9c14000-7f27e9e14000 ---p 00007000 fd:00 1464334                    /opt/local/lib/ruby/2.1.0/x86_64-linux/stringio.so
7f27e9e14000-7f27e9e15000 rw-p 00007000 fd:00 1464334                    /opt/local/lib/ruby/2.1.0/x86_64-linux/stringio.so
7f27e9e15000-7f27e9e24000 r-xp 00000000 fd:00 1464337                    /opt/local/lib/ruby/2.1.0/x86_64-linux/zlib.so
7f27e9e24000-7f27ea024000 ---p 0000f000 fd:00 1464337                    /opt/local/lib/ruby/2.1.0/x86_64-linux/zlib.so
7f27ea024000-7f27ea025000 rw-p 0000f000 fd:00 1464337                    /opt/local/lib/ruby/2.1.0/x86_64-linux/zlib.so
7f27ea025000-7f27ea04b000 r-xp 00000000 fd:00 1464338                    /opt/local/lib/ruby/2.1.0/x86_64-linux/socket.so
7f27ea04b000-7f27ea24b000 ---p 00026000 fd:00 1464338                    /opt/local/lib/ruby/2.1.0/x86_64-linux/socket.so
7f27ea24b000-7f27ea24c000 rw-p 00026000 fd:00 1464338                    /opt/local/lib/ruby/2.1.0/x86_64-linux/socket.so
7f27ea24c000-7f27ea24f000 r-xp 00000000 fd:00 1464333                    /opt/local/lib/ruby/2.1.0/x86_64-linux/digest.so
7f27ea24f000-7f27ea44f000 ---p 00003000 fd:00 1464333                    /opt/local/lib/ruby/2.1.0/x86_64-linux/digest.so
7f27ea44f000-7f27ea450000 rw-p 00003000 fd:00 1464333                    /opt/local/lib/ruby/2.1.0/x86_64-linux/digest.so
7f27ea450000-7f27ea46d000 r-xp 00000000 fd:00 3028086                    /lib64/libselinux.so.1
7f27ea46d000-7f27ea66c000 ---p 0001d000 fd:00 3028086                    /lib64/libselinux.so.1
7f27ea66c000-7f27ea66d000 r--p 0001c000 fd:00 3028086                    /lib64/libselinux.so.1
7f27ea66d000-7f27ea66e000 rw-p 0001d000 fd:00 3028086                    /lib64/libselinux.so.1
7f27ea66e000-7f27ea66f000 rw-p 00000000 00:00 0 
7f27ea66f000-7f27ea685000 r-xp 00000000 fd:00 3019901                    /lib64/libresolv-2.12.so
7f27ea685000-7f27ea885000 ---p 00016000 fd:00 3019901                    /lib64/libresolv-2.12.so
7f27ea885000-7f27ea886000 r--p 00016000 fd:00 3019901                    /lib64/libresolv-2.12.so
7f27ea886000-7f27ea887000 rw-p 00017000 fd:00 3019901                    /lib64/libresolv-2.12.so
7f27ea887000-7f27ea889000 rw-p 00000000 00:00 0 
7f27ea889000-7f27ea88b000 r-xp 00000000 fd:00 3028091                    /lib64/libkeyutils.so.1.3
7f27ea88b000-7f27eaa8a000 ---p 00002000 fd:00 3028091                    /lib64/libkeyutils.so.1.3
7f27eaa8a000-7f27eaa8b000 r--p 00001000 fd:00 3028091                    /lib64/libkeyutils.so.1.3
7f27eaa8b000-7f27eaa8c000 rw-p 00002000 fd:00 3028091                    /lib64/libkeyutils.so.1.3
7f27eaa8c000-7f27eaa96000 r-xp 00000000 fd:00 3019938                    /lib64/libkrb5support.so.0.1
7f27eaa96000-7f27eac95000 ---p 0000a000 fd:00 3019938                    /lib64/libkrb5support.so.0.1
7f27eac95000-7f27eac96000 r--p 00009000 fd:00 3019938                    /lib64/libkrb5support.so.0.1
7f27eac96000-7f27eac97000 rw-p 0000a000 fd:00 3019938                    /lib64/libkrb5support.so.0.1
7f27eac97000-7f27eacc0000 r-xp 00000000 fd:00 3019939                    /lib64/libk5crypto.so.3.1
7f27eacc0000-7f27eaec0000 ---p 00029000 fd:00 3019939                    /lib64/libk5crypto.so.3.1
7f27eaec0000-7f27eaec1000 r--p 00029000 fd:00 3019939                    /lib64/libk5crypto.so.3.1
7f27eaec1000-7f27eaec2000 rw-p 0002a000 fd:00 3019939                    /lib64/libk5crypto.so.3.1
7f27eaec2000-7f27eaec3000 rw-p 00000000 00:00 0 
7f27eaec3000-7f27eaec6000 r-xp 00000000 fd:00 3028094                    /lib64/libcom_err.so.2.1
7f27eaec6000-7f27eb0c5000 ---p 00003000 fd:00 3028094                    /lib64/libcom_err.so.2.1
7f27eb0c5000-7f27eb0c6000 r--p 00002000 fd:00 3028094                    /lib64/libcom_err.so.2.1
7f27eb0c6000-7f27eb0c7000 rw-p 00003000 fd:00 3028094                    /lib64/libcom_err.so.2.1
7f27eb0c7000-7f27eb1a2000 r-xp 00000000 fd:00 3019940                    /lib64/libkrb5.so.3.3
7f27eb1a2000-7f27eb3a1000 ---p 000db000 fd:00 3019940                    /lib64/libkrb5.so.3.3
7f27eb3a1000-7f27eb3ab000 r--p 000da000 fd:00 3019940                    /lib64/libkrb5.so.3.3
7f27eb3ab000-7f27eb3ad000 rw-p 000e4000 fd:00 3019940                    /lib64/libkrb5.so.3.3
7f27eb3ad000-7f27eb3ee000 r-xp 00000000 fd:00 3019941                    /lib64/libgssapi_krb5.so.2.2
7f27eb3ee000-7f27eb5ee000 ---p 00041000 fd:00 3019941                    /lib64/libgssapi_krb5.so.2.2
7f27eb5ee000-7f27eb5ef000 r--p 00041000 fd:00 3019941                    /lib64/libgssapi_krb5.so.2.2
7f27eb5ef000-7f27eb5f1000 rw-p 00042000 fd:00 3019941                    /lib64/libgssapi_krb5.so.2.2
7f27eb5f1000-7f27eb606000 r-xp 00000000 fd:00 3019900                    /lib64/libz.so.1.2.3
7f27eb606000-7f27eb805000 ---p 00015000 fd:00 3019900                    /lib64/libz.so.1.2.3
7f27eb805000-7f27eb806000 r--p 00014000 fd:00 3019900                    /lib64/libz.so.1.2.3
7f27eb806000-7f27eb807000 rw-p 00015000 fd:00 3019900                    /lib64/libz.so.1.2.3
7f27eb807000-7f27eb868000 r-xp 00000000 fd:00 2105796                    /usr/lib64/libssl.so.1.0.1e
7f27eb868000-7f27eba68000 ---p 00061000 fd:00 2105796                    /usr/lib64/libssl.so.1.0.1e
7f27eba68000-7f27eba6c000 r--p 00061000 fd:00 2105796                    /usr/lib64/libssl.so.1.0.1e
7f27eba6c000-7f27eba73000 rw-p 00065000 fd:00 2105796                    /usr/lib64/libssl.so.1.0.1e
7f27eba73000-7f27ebc28000 r-xp 00000000 fd:00 2105788                    /usr/lib64/libcrypto.so.1.0.1e
7f27ebc28000-7f27ebe28000 ---p 001b5000 fd:00 2105788                    /usr/lib64/libcrypto.so.1.0.1e
7f27ebe28000-7f27ebe43000 r--p 001b5000 fd:00 2105788                    /usr/lib64/libcrypto.so.1.0.1e
7f27ebe43000-7f27ebe4f000 rw-p 001d0000 fd:00 2105788                    /usr/lib64/libcrypto.so.1.0.1e
7f27ebe4f000-7f27ebe53000 rw-p 00000000 00:00 0 
7f27ebe53000-7f27ebe54000 r-xp 00000000 fd:00 1464358                    /opt/local/lib/ruby/2.1.0/x86_64-linux/digest/sha1.so
7f27ebe54000-7f27ec053000 ---p 00001000 fd:00 1464358                    /opt/local/lib/ruby/2.1.0/x86_64-linux/digest/sha1.so
7f27ec053000-7f27ec054000 rw-p 00000000 fd:00 1464358                    /opt/local/lib/ruby/2.1.0/x86_64-linux/digest/sha1.so
7f27ec054000-7f27ec057000 r-xp 00000000 fd:00 1464344                    /opt/local/lib/ruby/2.1.0/x86_64-linux/etc.so
7f27ec057000-7f27ec256000 ---p 00003000 fd:00 1464344                    /opt/local/lib/ruby/2.1.0/x86_64-linux/etc.so
7f27ec256000-7f27ec257000 rw-p 00002000 fd:00 1464344                    /opt/local/lib/ruby/2.1.0/x86_64-linux/etc.so
7f27ec257000-7f27ec25a000 r-xp 00000000 fd:00 1464351                    /opt/local/lib/ruby/2.1.0/x86_64-linux/io/console.so
7f27ec25a000-7f27ec459000 ---p 00003000 fd:00 1464351                    /opt/local/lib/ruby/2.1.0/x86_64-linux/io/console.so
7f27ec459000-7f27ec45a000 rw-p 00002000 fd:00 1464351                    /opt/local/lib/ruby/2.1.0/x86_64-linux/io/console.so
7f27ec45a000-7f27ec461000 r-xp 00000000 fd:00 1464332                    /opt/local/lib/ruby/2.1.0/x86_64-linux/pathname.so
7f27ec461000-7f27ec660000 ---p 00007000 fd:00 1464332                    /opt/local/lib/ruby/2.1.0/x86_64-linux/pathname.so
7f27ec660000-7f27ec661000 rw-p 00006000 fd:00 1464332                    /opt/local/lib/ruby/2.1.0/x86_64-linux/pathname.so
7f27ec661000-7f27ec664000 r-xp 00000000 fd:00 1464331                    /opt/local/lib/ruby/2.1.0/x86_64-linux/thread.so
7f27ec664000-7f27ec863000 ---p 00003000 fd:00 1464331                    /opt/local/lib/ruby/2.1.0/x86_64-linux/thread.so
7f27ec863000-7f27ec864000 rw-p 00002000 fd:00 1464331                    /opt/local/lib/ruby/2.1.0/x86_64-linux/thread.so
7f27ec864000-7f27ec866000 r-xp 00000000 fd:00 1464300                    /opt/local/lib/ruby/2.1.0/x86_64-linux/enc/trans/transdb.so
7f27ec866000-7f27eca66000 ---p 00002000 fd:00 1464300                    /opt/local/lib/ruby/2.1.0/x86_64-linux/enc/trans/transdb.so
7f27eca66000-7f27eca67000 rw-p 00002000 fd:00 1464300                    /opt/local/lib/ruby/2.1.0/x86_64-linux/enc/trans/transdb.so
7f27eca67000-7f27eca69000 r-xp 00000000 fd:00 1464283                    /opt/local/lib/ruby/2.1.0/x86_64-linux/enc/encdb.so
7f27eca69000-7f27ecc68000 ---p 00002000 fd:00 1464283                    /opt/local/lib/ruby/2.1.0/x86_64-linux/enc/encdb.so
7f27ecc68000-7f27ecc69000 rw-p 00001000 fd:00 1464283                    /opt/local/lib/ruby/2.1.0/x86_64-linux/enc/encdb.so
7f27ecc69000-7f27f2afa000 r--p 00000000 fd:00 2125341                    /usr/lib/locale/locale-archive
7f27f2afa000-7f27f2b6b000 r-xp 00000000 fd:00 3028088                    /lib64/libfreebl3.so
7f27f2b6b000-7f27f2d6a000 ---p 00071000 fd:00 3028088                    /lib64/libfreebl3.so
7f27f2d6a000-7f27f2d6c000 r--p 00070000 fd:00 3028088                    /lib64/libfreebl3.so
7f27f2d6c000-7f27f2d6d000 rw-p 00072000 fd:00 3028088                    /lib64/libfreebl3.so
7f27f2d6d000-7f27f2d71000 rw-p 00000000 00:00 0 
7f27f2d71000-7f27f2efc000 r-xp 00000000 fd:00 3028077                    /lib64/libc-2.12.so
7f27f2efc000-7f27f30fb000 ---p 0018b000 fd:00 3028077                    /lib64/libc-2.12.so
7f27f30fb000-7f27f30ff000 r--p 0018a000 fd:00 3028077                    /lib64/libc-2.12.so
7f27f30ff000-7f27f3100000 rw-p 0018e000 fd:00 3028077                    /lib64/libc-2.12.so
7f27f3100000-7f27f3105000 rw-p 00000000 00:00 0 
7f27f3105000-7f27f3188000 r-xp 00000000 fd:00 3028081                    /lib64/libm-2.12.so
7f27f3188000-7f27f3387000 ---p 00083000 fd:00 3028081                    /lib64/libm-2.12.so
7f27f3387000-7f27f3388000 r--p 00082000 fd:00 3028081                    /lib64/libm-2.12.so
7f27f3388000-7f27f3389000 rw-p 00083000 fd:00 3028081                    /lib64/libm-2.12.so
7f27f3389000-7f27f3390000 r-xp 00000000 fd:00 3028089                    /lib64/libcrypt-2.12.so
7f27f3390000-7f27f3590000 ---p 00007000 fd:00 3028089                    /lib64/libcrypt-2.12.so
7f27f3590000-7f27f3591000 r--p 00007000 fd:00 3028089                    /lib64/libcrypt-2.12.so
7f27f3591000-7f27f3592000 rw-p 00008000 fd:00 3028089                    /lib64/libcrypt-2.12.so
7f27f3592000-7f27f35c0000 rw-p 00000000 00:00 0 
7f27f35c0000-7f27f35c2000 r-xp 00000000 fd:00 3028084                    /lib64/libdl-2.12.so
7f27f35c2000-7f27f37c2000 ---p 00002000 fd:00 3028084                    /lib64/libdl-2.12.so
7f27f37c2000-7f27f37c3000 r--p 00002000 fd:00 3028084                    /lib64/libdl-2.12.so
7f27f37c3000-7f27f37c4000 rw-p 00003000 fd:00 3028084                    /lib64/libdl-2.12.so
7f27f37c4000-7f27f37cb000 r-xp 00000000 fd:00 3028079                    /lib64/librt-2.12.so
7f27f37cb000-7f27f39ca000 ---p 00007000 fd:00 3028079                    /lib64/librt-2.12.so
7f27f39ca000-7f27f39cb000 r--p 00006000 fd:00 3028079                    /lib64/librt-2.12.so
7f27f39cb000-7f27f39cc000 rw-p 00007000 fd:00 3028079                    /lib64/librt-2.12.so
7f27f39cc000-7f27f39e3000 r-xp 00000000 fd:00 3014737                    /lib64/libpthread-2.12.so
7f27f39e3000-7f27f3be3000 ---p 00017000 fd:00 3014737                    /lib64/libpthread-2.12.so
7f27f3be3000-7f27f3be4000 r--p 00017000 fd:00 3014737                    /lib64/libpthread-2.12.so
7f27f3be4000-7f27f3be5000 rw-p 00018000 fd:00 3014737                    /lib64/libpthread-2.12.so
7f27f3be5000-7f27f3be9000 rw-p 00000000 00:00 0 
7f27f3be9000-7f27f3c09000 r-xp 00000000 fd:00 3028076                    /lib64/ld-2.12.so
7f27f3ceb000-7f27f3df1000 rw-p 00000000 00:00 0 
7f27f3dfb000-7f27f3dfc000 rw-p 00000000 00:00 0 
7f27f3dfc000-7f27f3e03000 r--s 00000000 fd:00 2103363                    /usr/lib64/gconv/gconv-modules.cache
7f27f3e03000-7f27f3e04000 ---p 00000000 00:00 0 
7f27f3e04000-7f27f3e08000 rw-p 00000000 00:00 0                          [stack:8832]
7f27f3e08000-7f27f3e09000 r--p 0001f000 fd:00 3028076                    /lib64/ld-2.12.so
7f27f3e09000-7f27f3e0a000 rw-p 00020000 fd:00 3028076                    /lib64/ld-2.12.so
7f27f3e0a000-7f27f3e0b000 rw-p 00000000 00:00 0 
7f27f3e0b000-7f27f4091000 r-xp 00000000 fd:00 1463908                    /opt/local/bin/ruby
7f27f4291000-7f27f4297000 rw-p 00286000 fd:00 1463908                    /opt/local/bin/ruby
7f27f4297000-7f27f42bc000 rw-p 00000000 00:00 0 
7f27f5218000-7f27f6949000 rw-p 00000000 00:00 0                          [heap]
7fff82e72000-7fff82e93000 rw-p 00000000 00:00 0 
7fff82f83000-7fff82f85000 r--p 00000000 00:00 0                          [vvar]
7fff82f85000-7fff82f87000 r-xp 00000000 00:00 0                          [vdso]
ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]


[NOTE]
You may have encountered a bug in the Ruby interpreter or extension libraries.
Bug reports are welcome.
For details: http://www.ruby-lang.org/bugreport.html

[1]    8830 abort (core dumped)  bundle exec ruby test.rb
```


