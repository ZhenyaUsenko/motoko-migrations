import Migration001 "./001-initial/types";
import Migration002 "./002-add-full-name/types";

module {
  // do not forget to change current migration when you add a new one
  // you should use this field to import types from you current migration anywhere in your project
  // instead of importing it from migration folder itself
  public let Current = Migration002;

  public type Args = {
    deployer: Principal;
    // you can add any fields here to pass external data to your migrations
  };

  public type State = {
    #state000: { #id; #data: () };
    #state001: { #id; #data: Migration001.State };
    #state002: { #id; #data: Migration002.State };
    // do not forget to add your new migration state types here
  };
};