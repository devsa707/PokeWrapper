program PokeWrapper;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  PokeWrapper.Interfaces in '..\Source\API\PokeWrapper.Interfaces.pas',
  PokeWrapper in '..\Source\API\PokeWrapper.pas',
  PokeWrapper.Resources in '..\Source\API\PokeWrapper.Resources.pas',
  PokeWrapper.Types in '..\Source\API\PokeWrapper.Types.pas',
  PokeList.Entity in '..\Source\List\PokeList.Entity.pas',
  Berry.Entity in '..\Source\Entities\Berries\Berry.Entity.pas';

var
  FPokeAPI: IPokeAPI;
  FPokeListEntity: TPokeListEntity;

begin
  FPokeListEntity := nil;
  try
    ReportMemoryLeaksOnShutdown := True;
    Writeln('***********************************');
    Writeln('*****     PokeWrapper         *****');
    Writeln('*github.com/devsa707/PokeWrapper4D*');
    Writeln('***********************************');
    Writeln('');

    // <T> is the header value for search
    FPokeAPI := TPokeAPI<TPokemon>.Create;
    Writeln(FPokeAPI.Get(integer(pokemon), 1));
    Writeln('');
    Writeln('');

    // Get a list based on its enumerate
    FPokeListEntity := FPokeAPI.GetAsListEntity(integer(pokemon));

    // prints the entity if not nil
    if FPokeListEntity <> nil then
    begin
      Writeln('Count: ' + FPokeListEntity.count.ToString);
      Writeln('Next: ' + FPokeListEntity.next);
      Writeln('Previous: ' + FPokeListEntity.previous);
      for var I := 0 to FPokeListEntity.results.count - 1 do
      begin
        Writeln('Name: ' + FPokeListEntity.results.Items[I].name);
        Writeln('URL: ' + FPokeListEntity.results.Items[I].url);
      end;
    end;

    Writeln('');
    Writeln('');
    Writeln('***********************************');
    Writeln('***** PRESS ENTER TO CONTINUE *****');
    Writeln('***********************************');
    ReadLn;
  finally
    FPokeListEntity.Free;
  end;

end.
