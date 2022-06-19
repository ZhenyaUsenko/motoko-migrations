import Array "mo:base/Array";
import Types001 "../001-initial/types";
import Types002 "./types";
import MigrationTypes "../types";

module {
  public func upgrade(prevMigrationState: MigrationTypes.State, args: MigrationTypes.Args): MigrationTypes.State {
    // access previous state
    let #state001(#data(prevState)) = prevMigrationState;

    // make any manipulations with previous state to convert it to current migration state type
    let teachers = Array.map(prevState.teachers, func (item: Types001.Teacher): Types002.Teacher {
      return {
        firstName = item.firstName;
        lastName = item.lastName;
        fullName = item.firstName # " " # item.lastName;
        subject = item.subject;
      };
    });

    let students = Array.map(prevState.students, func (item: Types001.Student): Types002.Student {
      return {
        firstName = item.firstName;
        lastName = item.lastName;
        fullName = item.firstName # " " # item.lastName;
        speciality = item.speciality;
      };
    });

    // return current state
    return #state002(#data({
      var admin = prevState.admin;
      var teachers;
      var students;
    }));
  };

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  public func downgrade(migrationState: MigrationTypes.State, args: MigrationTypes.Args): MigrationTypes.State {
    // access current state
    let #state002(#data(state)) = migrationState;

    // make any manipulations with current state to convert it to previous migration state type
    let teachers = Array.map(state.teachers, func (item: Types002.Teacher): Types001.Teacher {
      return {
        firstName = item.firstName;
        lastName = item.lastName;
        subject = item.subject;
      };
    });

    let students = Array.map(state.students, func (item: Types002.Student): Types001.Student {
      return {
        firstName = item.firstName;
        lastName = item.lastName;
        speciality = item.speciality;
      };
    });

    // return previous state
    return #state001(#data({
      var admin = state.admin;
      var teachers;
      var students;
    }));

    // if you are sure you wont need downgrades in your project, you can just "return #state000(#data);"
    // note that it will fail to deploy if you then try to downgrade
  };
};