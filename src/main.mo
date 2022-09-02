import Array "mo:base/Array";
import Debug "mo:base/Debug";
import MigrationTypes "./migrations/types";
import Migrations "./migrations";
import Types "./types";

shared ({ caller = deployer }) actor class MotokoMigrations() {
  let StateTypes = MigrationTypes.Current;

  // you will have only one stable variable
  // move all your stable variable declarations to "migrations/001-initial/types.mo -> State"
  stable var migrationState: MigrationTypes.State = #v0_0_0(#data);

  // do not forget to change #v0_2_0 when you are adding a new migration
  // if you use one of previus states in place of #v0_2_0 it will run downgrade methods instead
  migrationState := Migrations.migrate(migrationState, #v0_2_0(#id), { deployer });

  // do not forget to change #v0_2_0 when you are adding a new migration
  let state = switch (migrationState) { case (#v0_2_0(#data(state))) state; case (_) Debug.trap("Unexpected migration state") };

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  public shared func addTeacher(teacher: StateTypes.Teacher): async () {
    state.teachers := Array.append(state.teachers, [teacher]);
  };

  public shared func addStudent(student: StateTypes.Student): async () {
    state.students := Array.append(state.students, [student]);
  };

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  public query func fetchTeachers(): async Types.FetchTeachersResponse {
    return {
      items = state.teachers;
      totalCount = state.teachers.size();
    };
  };

  public query func fetchStudents(): async Types.FetchStudentsResponse {
    return {
      items = state.students;
      totalCount = state.students.size();
    };
  };
};
