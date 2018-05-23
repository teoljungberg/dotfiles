setlocal iskeyword+=?,!,=

" abbreviations
iabbrev dinit def initialize
iabbrev ddebug require 'irb'; binding.irb

let b:start = "irb -r '%:p'"

if expand("%") =~# "_test\.rb$"
  let b:dispatch = "ruby -Itest %"
elseif expand("%") =~# "_spec\.rb$"
  let b:dispatch = "rspec %"
elseif !exists("b:dispatch")
  let b:dispatch = "ruby -wc %"
endif

if expand("%") =~# "_spec\.rb$"
  syn match rubyTestHelper "\<subject\>"
  syn match rubyTestMacro "\<let\>!\="
  syn keyword rubyTestMacro after around before
  syn keyword rubyTestMacro
        \ context
        \ describe
        \ feature
        \ containedin=rubyKeywordAsMethod
  syn keyword rubyTestMacro it it_behaves_like
  syn keyword rubyComment
        \ xcontext
        \ xdescribe
        \ xfeature
        \ containedin=rubyKeywordAsMethod
  syn keyword rubyComment xit
  syn keyword rubyAssertion
        \ allow
        \ expect
        \ is_expected
        \ skip
  syn keyword rubyTestHelper
        \ class_double
        \ described_class
        \ double
        \ instance_double
        \ instance_spy
        \ spy
endif
