import Array "mo:base/Array";
import Debug "mo:base/Debug";
import MigrationTypes "../types";
import V0_1_0 "../00-01-00-initial/types";
import V0_2_0 "./types";

module {
  public func upgrade(migrationState: MigrationTypes.State, args: MigrationTypes.Args): MigrationTypes.State {
    // access previous state
    let state = switch (migrationState) { case (#v0_1_0(#data(state))) state; case (_) Debug.trap("Unexpected migration state") };

    // make any manipulations with previous state to convert it to current migration state type
    let teachers = Array.map(state.teachers, func (item: V0_1_0.Teacher): V0_2_0.Teacher {
      return {
        firstName = item.firstName;
        lastName = item.lastName;
        fullName = item.firstName # " " # item.lastName;
        subject = item.subject;
      };
    });

    let students = Array.map(state.students, func (item: V0_1_0.Student): V0_2_0.Student {
      return {
        firstName = item.firstName;
        lastName = item.lastName;
        fullName = item.firstName # " " # item.lastName;
        speciality = item.speciality;
      };
    });

    // return current state
    return #v0_2_0(#data({
      var admin = state.admin;
      var teachers;
      var students;
    }));
  };

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  public func downgrade(migrationState: MigrationTypes.State, args: MigrationTypes.Args): MigrationTypes.State {
    // access current state
    let state = switch (migrationState) { case (#v0_2_0(#data(state))) state; case (_) Debug.trap("Unexpected migration state") };

    // make any manipulations with current state to convert it to previous migration state type
    let teachers = Array.map(state.teachers, func (item: V0_2_0.Teacher): V0_1_0.Teacher {
      return {
        firstName = item.firstName;
        lastName = item.lastName;
        subject = item.subject;
      };
    });

    let students = Array.map(state.students, func (item: V0_2_0.Student): V0_1_0.Student {
      return {
        firstName = item.firstName;
        lastName = item.lastName;
        speciality = item.speciality;
      };
    });

    // return previous state
    return #v0_1_0(#data({
      var admin = state.admin;
      var teachers;
      var students;
    }));

    // if you are sure you wont need downgrades in your project, you can just "return #v0_0_0(#data);"
    // note that it will fail to deploy if you then try to downgrade
  };
};