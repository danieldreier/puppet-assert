# this class is only here so puppet recognizes this as a valid puppet module
class assert {
  fail('do not include the ::assert class')
}
