" https://github.com/prettier/prettier/blob/eea7d11883bb7e5d8758f740aac08d81c0e2822f/src/language-js/index.js#L80
if expand("%") =~ '^package\(-lock\)\?\.json$'
  let b:prettier_ft_default_args = {
        \ 'parser': 'json-stringify',
        \ }
endif
