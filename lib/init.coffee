module.exports =
  configDefaults:
    phpcsExecutablePath: null
    standard: '~/Sites/rules.xml'
    ignore: '*.blade.php,*.twig.php'
    enableWarning: 1
    tabWidth: 4

  activate: ->
    console.log 'activate linter-phpcs'
