import MigrationTypes "../types";

module {
  public func upgrade(prevMigrationState: MigrationTypes.State, args: MigrationTypes.Args): MigrationTypes.State {
    return #state001(#data({
      var admin = args.deployer;
      var teachers = [];
      var students = [];
    }));
  };

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  public func downgrade(migrationState: MigrationTypes.State, args: MigrationTypes.Args): MigrationTypes.State {
    return #state000(#data);
  };
};