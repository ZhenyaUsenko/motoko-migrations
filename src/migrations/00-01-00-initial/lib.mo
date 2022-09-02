import MigrationTypes "../types";

module {
  public func upgrade(prevMigrationState: MigrationTypes.State, args: MigrationTypes.Args): MigrationTypes.State {
    return #v0_1_0(#data({
      var admin = args.deployer;
      var teachers = [];
      var students = [];
    }));
  };

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  public func downgrade(migrationState: MigrationTypes.State, args: MigrationTypes.Args): MigrationTypes.State {
    return #v0_0_0(#data);
  };
};