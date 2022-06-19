import Array "mo:base/Array";
import Types "./types";
import Migrations "./migrations";
import MigrationTypes "./migrations/types";

shared deployer actor class MotokoMigrations() {
  let StateTypes = MigrationTypes.Current;

  // you will have only one stable variable
  // move all your stable variable declarations to "migrations/001-initial/types.mo -> State"
  stable var migrationState: MigrationTypes.State = #state000(#data);

  // do not forget to change #state002 when you are adding a new migration
  // if you use one previus states in place of #state002 it will run downgrade methods instead
  migrationState := Migrations.migrate(migrationState, #state002(#id), { deployer = deployer.caller });

  // do not forget to change #state002 when you are adding a new migration
  let #state002(#data(state)) = migrationState;

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
