import Migration001 "./001-initial";
import Migration002 "./002-add-full-name";
import MigrationTypes "./types";

module {
  let upgrades = [
    Migration001.upgrade,
    Migration002.upgrade,
    // do not forget to add your new migration upgrade method here
  ];

  let downgrades = [
    Migration001.downgrade,
    Migration002.downgrade,
    // do not forget to add your new migration downgrade method here
  ];

  func getMigrationId(state: MigrationTypes.State): Nat {
    return switch (state) {
      case (#state000(_)) 0;
      case (#state001(_)) 1;
      case (#state002(_)) 2;
      // do not forget to add your new migration id here
      // should be increased by 1 as it will be later used as an index to get upgrade/downgrade methods
    };
  };

  public func migrate(
    prevState: MigrationTypes.State, 
    nextState: MigrationTypes.State, 
    args: MigrationTypes.Args
  ): MigrationTypes.State {
    var state = prevState;
    var migrationId = getMigrationId(prevState);

    let nextMigrationId = getMigrationId(nextState);

    while (migrationId != nextMigrationId) {
      let migrate = if (nextMigrationId > migrationId) upgrades[migrationId] else downgrades[migrationId - 1];

      migrationId := if (nextMigrationId > migrationId) migrationId + 1 else migrationId - 1;

      state := migrate(state, args);
    };

    return state;
  };
};