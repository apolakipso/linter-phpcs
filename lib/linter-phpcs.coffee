linterPath = atom.packages.getLoadedPackage("linter").path
Linter = require "#{linterPath}/lib/linter"

class LinterPhpcs extends Linter
  # The syntax that the linter handles. May be a string or
  # list/tuple of strings. Names should be all lowercase.
  @syntax: ['text.html.php', 'source.php']

  linterName: 'phpcs'

  # A regex pattern used to extract information from the executable's output.
  regex: '.*line="(?<line>[0-9]+)" column="(?<col>[0-9]+)" severity="((?<error>error)|(?<warning>warning))" message="(?<message>.*)" source'

  executablePath: null

  constructor: (editor)->
    super(editor)

    atom.config.observe 'linter-phpcs.phpcsExecutablePath', =>
      @executablePath = atom.config.get 'linter-phpcs.phpcsExecutablePath'

    atom.config.observe 'linter-phpcs.standard', =>
      @updateCommand()

    atom.config.observe 'linter-phpcs.ignore', =>
      @updateCommand()

    atom.config.observe 'linter-phpcs.enableWarning', =>
      @updateCommand()

    atom.config.observe 'linter-phpcs.tabWidth', =>
      @updateCommand()

  destroy: ->
    atom.config.unobserve 'linter-phpcs.phpcsExecutablePath'
    atom.config.unobserve 'linter-phpcs.standard'
    atom.config.unobserve 'linter-phpcs.enableWarning'
    atom.config.unobserve 'linter-phpcs.ignore'
    atom.config.unobserve 'linter-phpcs.tabWidth'

   updateCommand: ->
    standard = atom.config.get 'linter-phpcs.standard'
    ignore = atom.config.get 'linter-phpcs.ignore'
    warning = atom.config.get 'linter-phpcs.enableWarning'
    tabWidth = atom.config.get 'linter-phpcs.tabWidth'

    @cmd = "phpcs --report=checkstyle --tab-width=#{tabWidth} --warning-severity=#{warning}"

    if standard
        @cmd += " --standard=#{standard}"

    if ignore
        @cmd += " --ignore=#{ignore}"

module.exports = LinterPhpcs
