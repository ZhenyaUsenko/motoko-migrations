import MigrationTypes "./migrations/types";

module {
  let StateTypes = MigrationTypes.Current;

  public type FetchTeachersResponse = {
    items: [StateTypes.Teacher];
    totalCount: Nat;
  };

  public type FetchStudentsResponse = {
    items: [StateTypes.Student];
    totalCount: Nat;
  };
};
