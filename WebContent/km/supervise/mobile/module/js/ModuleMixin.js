define(["dojo/_base/declare", "./Index", "./LeaderConcern", "./AllSupervise", "./MySupervise"], function(
  declare,
  Index,
  LeaderConcern,
  AllSupervise,
  MySupervise,
  Admin
) {
  return declare("kms.supervise.module.ModuleMixin", null, {
    views: [Index, LeaderConcern, AllSupervise, MySupervise]
  })
})
