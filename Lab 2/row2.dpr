program row2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  Sweets = record
    Id: ShortInt;
    Name: string[255];
  end;

  TPSWeets = ^PSweets;

  PSweets = record
    Info: Sweets;
    Adr: TPSweets;
  end;

  SweetsTypes = record
    NameTypes: string[255];
    SweetId: ShortInt;
    IDs: ShortInt;
    Value: string[255];
    weight: string[255];
    SugarC: Cardinal;
  end;

  TPSweetsTypes = ^PSweetsTypes;

  PSweetsTypes = record
    Info: SweetsTypes;
    Adr: TPSweetsTypes;
  end;

  SweetsTypesArray = array of SweetsTypes;

  TPNYPresents = ^PNYPresents;

  PNYPresents = record
    Info: SweetsTypesArray;
    name: string[255];
    ID: ShortInt;
    SummWeight: ShortInt;
    SummTypes: ShortInt;
    SummSCount: Cardinal;
    adr: TPNYPresents;
  end;

  IdCounter1 = byte;

  IdCounter2 = byte;

var
  ListS: TPSweets;
  ListST: TPSweetsTypes;
  ListP: TPNYPresents;
  k: string[255];
  lel: byte;
  i: ShortInt;
  j: ShortInt;
  q: ShortInt;
  tempname: string[255];
  kek: ShortInt;
  r: integer;

procedure CheckNumber(s: byte);
begin

end;

procedure sortSCount(const head: TPNYPresents);
var
  i: integer;
  temp: TPNYPresents;
  temp2: TPNYPresents;
  t1: TPNYPresents;
begin
  temp := head;
  while temp.adr <> nil do
  begin
    temp2 := temp.adr;
    while temp2.adr <> nil do
    begin
      if temp2^.SummSCount < temp^.SummSCount then
      begin

        t1 := temp2^.adr;
        temp2^.adr := temp^.adr;
        temp^.adr := t1;

        t1 := temp^.adr^.adr;
        temp^.adr^.adr := temp2^.adr.adr;
        temp2^.adr^.adr := t1;

        temp2 := temp;
      end;
      temp2 := temp2^.adr;
    end;
    temp := temp^.adr;
  end;
end;

procedure SortBublInf(const u: TPNYPresents);
var
  tmp, x: TPNYPresents;
  tmps: TPNYPresents;
begin
  x := u;
  while x.adr <> nil do
  begin
    tmp := x.adr;
    while tmp.adr <> nil do
    begin
      if tmp^.SummSCount < x^.SummSCount then
      begin
        tmps := tmp;
        tmp := x;
        x := tmps;
      end;
      tmp := tmp^.adr;
    end;
    x := x^.adr;
  end
end;

procedure AddNewSweets(const List: TPSWeets; var i: ShortInt; StrAdd: string);
var
  Temp: TPSWeets;
begin
  Temp := List;
  while Temp^.adr <> nil do
    Temp := Temp^.adr;

  new(Temp^.adr);
  Temp := Temp^.adr;
  Temp^.adr := nil;
  Temp^.Info.Id := i;
  Inc(i);
  Temp^.info.Name := StrAdd;
end;

function FindSweetId(const nameoftype: string; const List1: TPSWeets): ShortInt;
var
  temp1: TPSWeets;
begin
  FindSweetId := -1;
  temp1 := List1;
  while temp1 <> nil do
  begin
    if temp1^.Info.name = nameoftype then
      FindSweetId := temp1^.Info.Id;
    temp1 := temp1^.Adr;
  end;
end;

procedure AddNewSweetType(const List: TPSweetsTypes; var i: ShortInt; nameoftypes, value, weight: string; kek: ShortInt; sugarc: cardinal);
var
  Temp: TPSWeetsTypes;
begin
  Temp := List;
  while Temp^.adr <> nil do
    Temp := Temp^.adr;

  new(Temp^.adr);
  Temp := Temp^.adr;
  Temp^.adr := nil;
  //Inc(i);
  Temp^.Info.Ids := i;
  Inc(i);

  Temp^.Info.NameTypes := nameoftypes;
  Temp^.Info.value := value;
  Temp^.Info.weight := weight;
  Temp^.Info.sugarc := sugarc;
  Temp^.Info.SweetId := kek;

end;

procedure WriteListSweets(const List1: TPSWeets);
var
  temp: TPSWeets;
begin
  Writeln('   ID    |   Name of Sweet               ');
  Writeln('-----------------------------------------');
  temp := List1;
  if temp^.adr = nil then
    write('   Empty list')
  else
  begin
    while temp^.adr <> nil do
    begin
      temp := temp^.Adr;
      Writeln('   ', temp^.info.id, '          ', temp^.info.name);
    end;
  end;
end;

function getnameofsweet(const List: TPSWeets; id: ShortInt): string;
var
  temp1: TPSWeets;
begin
  getnameofsweet := '';
  temp1 := List;
  while temp1 <> nil do
  begin
    if temp1^.Info.Id = id then
      getnameofsweet := temp1^.Info.name;
    temp1 := temp1^.Adr;
  end;
end;

procedure WriteListSweetsTypes(const List: TPSWeetsTypes);
var
  temp: TPSWeetsTypes;
begin
  Writeln('   ID    |    Sweet    | Sweet Type Name |   Value   |   Weight  |   Sugar   ');
  Writeln('_____________________________________________________________________________');
  Writeln;
  temp := List;
  if temp^.adr = nil then
    write('       Empty List    ')
  else
    while temp^.adr <> nil do
    begin
      temp := temp^.Adr;
      Writeln(temp.info.ids: 4, '', getnameofsweet(ListS, temp.info.sweetid): 15, '', temp.info.nametypes: 20, '     ', temp.info.value: 4, '        ', temp.info.weight: 4, '           ', temp.info.sugarc: 4);
    end;
end;

procedure SaveListSToFile(const list: TPSWeets);
var
  f: file of sweets;
  temp: TPSWeets;
  filename: string;
begin
  temp := list;
  temp := temp^.Adr;
  filename := 'Sweets.txt';
  AssignFile(f, filename);
  Rewrite(f);
  while temp <> nil do
  begin
    write(f, temp^.info);
    temp := temp^.Adr;
  end;
  Closefile(f);
end;

procedure SaveListSToFileTypes(const list: TPSweetsTypes);
var
  f: file of SweetsTypes;
  temp: TPSweetsTypes;
  filename: string;
begin
  temp := list;
  temp := temp^.Adr;
  filename := 'SweetsTypes.txt';
  AssignFile(f, filename);
  Rewrite(f);
  while temp <> nil do
  begin
    write(f, temp^.info);
    temp := temp^.Adr;
  end;
  Closefile(f);
end;

{procedure SaveListSToFileP(const list: TPNYPresents);
var
  f: file of PNYPresents;
  temp: TPNYPresents;
  filename: string;
begin
  temp := list;
  temp := temp^.Adr;
  filename := 'SweetsTypesPresents.txt';
  AssignFile(f, filename);
  Rewrite(f);
  while temp <> nil do
  begin
    write(f, temp^.info);
    temp := temp^.Adr;
  end;
  Closefile(f);
end;}

procedure ListFree(const List: TPSWeets);
var
  temp, del: TPSWeets;
begin

  if List <> nil then
  begin
    temp := List;
    while temp^.Adr <> nil do
    begin
      del := temp;
      temp := temp^.Adr;
      Dispose(del);
    end;
    Dispose(temp);
  end;
end;

procedure ListFreeTypes(const List: TPSweetsTypes);
var
  temp, del: TPSweetsTypes;
begin

  if List <> nil then
  begin
    temp := List;
    while temp^.Adr <> nil do
    begin
      del := temp;
      temp := temp^.Adr;
      Dispose(del);
    end;
    Dispose(temp);
  end;
end;

procedure ReadFromFileSweets(const List: TPSWeets);
var
  temp: TPSWeets;
  f: file of sweets;
  tempRec: Sweets;
  filename: string;
  kek: ShortInt;
begin
  temp := List;
  filename := 'Sweets.txt';
  AssignFile(f, filename);
  Reset(f);
  while not (Eof(f)) do
  begin
    read(f, tempRec);
    AddNewSweets(temp, tempRec.id, tempRec.Name);
    temp := temp^.Adr;
  end;
  //kek := -1;
 // AddNewSweets(temp, kek, 'nill');
  i := tempRec.Id;
  CloseFile(f);
end;

procedure ReadFromFileSweetsTypes(const List: TPSweetsTypes);
var
  temp: TPSweetsTypes;
  f: file of SweetsTypes;
  tempRec: SweetsTypes;
  filename: string;
  kek: ShortInt;
begin
  temp := List;
  filename := 'SweetsTypes.txt';
  AssignFile(f, filename);
  Reset(f);
  while not (Eof(f)) do
  begin
    read(f, tempRec);
    AddNewSweetType(temp, j, tempRec.NameTypes, tempRec.Value, tempRec.weight, tempRec.SweetId, tempRec.SugarC);
    temp := temp^.Adr;
  end;
 // kek := -1;
 // AddNewSweetType(temp, kek, 'nill', 'nill', 'nill', 'nill', kek);
  j := tempRec.IDs + 1;
  CloseFile(f);
end;

procedure FillListS(const List: TPSweetsTypes);
var
  Temp: TPSweetsTypes;
  nameofsweet, tempnamet, tempvalue, tempweigth: string;
  tempsugarc: Cardinal;
begin
  Temp := List;
  Writeln('Enter name of Sweets, whic conatain new type of sweeet: ');
  readln(nameofsweet);
  if FindSweetId(nameofsweet, ListS) <> -1 then
  begin
    Writeln('Enter Name of Sweet Type: ');
    Readln(tempnamet);
    Writeln('Enter value of Sweet Type: ');
    Readln(tempvalue);
    Writeln('Enter weight of Sweeet Type: ');
    Readln(tempweigth);
    Writeln('Enter Sugar Count of Sweet Type: ');
    Readln(tempsugarc);
    AddNewSweetType(ListST, j, tempnamet, tempvalue, tempweigth, FindSweetId(nameofsweet, ListS), tempsugarc);
    Writeln;
    writeln;
  end
  else
    Writeln(' I dont find this name:(');
end;

procedure ShowLists;
var
  k1: string;
begin
  repeat
    Writeln;
    Writeln('_______________________________');
    Writeln;
    Writeln('View List of Sweeets: 1');
    Writeln('View List of Sweeets Types: 2');
    Writeln('Exit in main menu: 3');
    Writeln('_______________________________');
    readln(k1);
    val(k1, lel, r);
    if lel in [1..3] then
    begin
      case lel of
        1:
          WriteListSweets(ListS);
        2:
          WriteListSweetsTypes(ListST);
      end;
    end
    else
    begin
      Writeln;
      Writeln('Please, try again ');
    end;
  until lel = 3;
end;

procedure EditSweetsFields(const list: TPSWeets);
var
  temp: tpsweets;
  id: ShortInt;
  name: string[255];
begin
  temp := list;
  Writeln;
  Writeln('Enter ID of target sweet:');
  Readln(id);
  if temp = nil then
    write('Empty List')
  else
  begin
    while temp <> nil do
    begin
      if temp.Info.Id = id then
      begin
        Writeln('Enter new name: ');
        Readln(name);
        temp.Info.Name := name;
      end;
      temp := temp^.adr;
    end;
  end;
end;

procedure EditSweetsTypesFields(const list: TPSweetsTypes);
var
  temp: TPSweetsTypes;
  id: ShortInt;
  name: string[255];
  sugarcount: Cardinal;
  k8: string;
begin
  temp := list;
  if temp = nil then
    write('Empty List')
  else
  begin
    repeat
      WriteListSweetsTypes(ListST);
      Writeln;
      Writeln('Enter ID of target sweet:');
      Readln(id);
      writeln;
      Writeln('1: Name of Sweet Type');
      Writeln('2: Value');
      Writeln('3: Weight');
      Writeln('4: Count of sugar');
      Writeln('5: Exit to editing menu');
      readln(k8);
      val(k8, lel, r);
      if lel in [1..4] then
      begin
        case lel of
          1: {name}
            begin
              while temp <> nil do
              begin
                if temp.Info.ids = id then
                begin
                  Writeln('Enter new name: ');
                  Readln(name);
                  temp.Info.NameTypes := name;
                end;
                temp := temp^.adr;
              end;
            end;
          2: {value}
            begin
              while temp <> nil do
              begin
                if temp.Info.ids = id then
                begin
                  Writeln('Enter new value: ');
                  Readln(name);
                  temp.Info.Value := name;
                end;
                temp := temp^.adr;
              end;
            end;
          3: {weight}
            while temp <> nil do
            begin
              if temp.Info.ids = id then
              begin
                Writeln('Enter new weight: ');
                Readln(name);
                temp.Info.weight := name;
              end;
              temp := temp^.adr;
            end;
          4: {sugarcount}
            while temp <> nil do
            begin
              if temp.Info.ids = id then
              begin
                Writeln('Enter new Sugar count: ');
                Readln(sugarcount);
                temp.Info.SugarC := sugarcount;
              end;
              temp := temp^.adr;
            end;
        end;
      end
      else
      begin
        Writeln;
        Writeln('Please, try again ');
      end;
    until lel = 5;
  end;
end;

procedure editrecordSweet;
var
  k5: string;
begin
  repeat
    WriteListSweets(ListS);
    Writeln;
    Writeln('To Edit name of Sweet press 1: ');
    Writeln('To Exit in editing menu press 2:');
    Writeln('________________________________');
    Writeln;
    Readln(k5);
    val(k5, lel, r);
    if lel in [1..2] then
    begin
      case lel of
        1:
          begin
            EditSweetsFields(ListS);
          end;
      end;
    end
    else
      Writeln;
    Writeln('Please, try again');
  until lel = 2;
end;

procedure editrecordsweettypes;
var
  k6: string;
begin
  repeat
    WriteListSweetsTypes(ListST);
    Writeln;
    Writeln('To Edit fields of Sweet Types press 1: ');
    Writeln('To Exit in editing menu press 2:');
    Writeln('________________________________');
    Writeln;
    Readln(k6);
    val(k6, lel, r);
    if lel in [1..2] then
    begin
      case lel of
        1:
          begin
            EditSweetsTypesFields(ListST);
          end;
      end;
    end
    else
    begin
      Writeln;
      Writeln('Please, try again ');
    end;
  until lel = 2;
end;

procedure DeleteSweet(const List: TPSWeets; const List2: TPSweetsTypes; const idDel: ShortInt);
var
  temp, deltemp: TPSweets;
  temp2, deltemp2: TPSweetsTypes;
begin
  temp := List;
  temp2 := List2;
  if temp = nil then
    write('Empty List')
  else
  begin
    while temp.adr <> nil do
    begin
      if temp^.adr.Info.Id = idDel then
      begin
        while temp2.adr <> nil do
        begin
          if temp2^.adr.Info.SweetId = idDel then
          begin
            deltemp2 := temp2.adr;
            temp2.adr := temp2.Adr.adr;
            Dispose(deltemp2);
          end
          else
            temp2 := temp2^.Adr;
        end;
        deltemp := temp.adr;
        temp.adr := temp.Adr.adr;
        Dispose(deltemp);
      end
      else
        temp := temp^.Adr;
    end;
  end;
end;

procedure DeleteSweetTypes(const List: TPSweetsTypes; const idDel: ShortInt);
var
  temp, deltemp: TPSweetsTypes;
begin
  temp := List;
  if temp = nil then
    write('Empty List')
  else
  begin
    while temp.adr <> nil do
    begin
      if temp^.adr.Info.Ids = idDel then
      begin
        deltemp := temp.adr;
        temp.adr := temp.Adr.adr;
        Dispose(deltemp);
      end
      else
        temp := temp^.Adr;
    end;
  end;
end;

procedure EditSweetsTypes;
var
  iddel: ShortInt;
  k4: string;
begin
  repeat
    WriteListSweetsTypes(ListST);
    Writeln;
    Writeln('_______________________________');
    Writeln;
    Writeln('Edit Sweet Types: 1');
    Writeln('Delete Sweet Types: 2');
    Writeln('Exit in editing menu: 3');
    Writeln('_______________________________');

    readln(k4);
    val(k4, lel, r);
    if lel in [1..3] then
    begin
      case lel of
        1:
          begin
            editrecordSweettypes;
          end;
        2:
          begin
            Writeln('Enter ID of sweet type, which will be deleted: ');
            Readln(iddel);
            DeleteSweetTypes(ListST, iddel);
          end;
      end;
    end
    else
    begin
      Writeln;
      Writeln('Please, try again ');
    end;

  until lel = 3;
end;

procedure EditSweets;
var
  iddel: ShortInt;
  k3: string;
begin
  repeat
    WriteListSweets(ListS);
    Writeln;
    Writeln('_______________________________');
    Writeln;
    Writeln('Edit Sweet: 1');
    Writeln('Delete Sweet: 2');
    Writeln('Exit in editing menu: 3');
    Writeln('_______________________________');
    readln(k3);
    val(k3, lel, r);
    if lel in [1..3] then
    begin
      case lel of
        1:
          begin
            editrecordSweet;
          end;
        2:
          begin
            Writeln('Enter ID of sweet, which will be deleted: ');
            Readln(iddel);
            DeleteSweet(ListS, ListST, iddel);

          end;
      end;
    end
    else
    begin
      Writeln;
      Writeln('Please, try again ');
    end;

  until lel = 3;
end;

procedure FreeAll;
begin
  i := 0;
  j := 0;
  ListFree(ListS);
  ListFreeTypes(ListSt);
  New(ListSt);
  New(listS);
  ListS^.adr := nil;
  ListST^.Adr := nil;
end;

procedure EditLists;
var
  k2: string;
begin
  repeat
    Writeln;
    Writeln('_______________________________');
    Writeln;
    Writeln('Add New Sweeets: 1');
    Writeln('Add New Sweeets Types: 2');
    Writeln('Edit Sweets: 3');
    Writeln('Edit Sweets Types: 4');
    Writeln('Save Lists: 5');
    Writeln('Read List From Files: 6');
    Writeln('Clear all lists: 7');
    Writeln('Exit in main menu: 8');
    Writeln('_______________________________');
    readln(k2);
    val(k2, lel, r);
    if lel in [1..8] then
    begin
      case lel of
        1:
          begin
            Writeln('Enter name of Sweet: ');
            readln(tempname);
            AddNewSweets(ListS, i, TempName);
          end;
        2:
          begin
            FillListS(ListST);
          end;
        3:
          begin
            EditSweets;
          end;
        4:
          begin
            EditSweetsTypes;
          end;
        5:
          begin
            SaveListSToFile(ListS);
            SaveListSToFileTypes(ListST);
          end;
        6:
          begin
            FreeAll;
            ReadFromFileSweets(ListS);
            ReadFromFileSweetsTypes(ListSt);
          end;
        7:
          begin
            FreeAll;
          end;
      end;
    end
    else
    begin
      Writeln;
      Writeln('Please, try again ');
    end;
  until lel = 8;
end;

function countelements(const List: TPSweetsTypes): byte;
var
  temp: TPSweetsTypes;
  count: Byte;
begin
  count := 0;
  temp := List;
  if temp = nil then
    write('Empty List')
  else
  begin
    while temp.adr <> nil do
    begin
      Inc(count);
      temp := temp^.Adr;
    end;
  end;
  countelements := count;
end;

procedure Generate(const list: TPNYPresents; const list2: TPSweetsTypes);
var
  Temp: TPNYPresents;
  temp2, temp3: TPSweetsTypes;
  ranIndex: Byte;
  kek, counter: byte;
  nameof: string[255];
  summWeight: shortint;
  summSCount: Cardinal;
begin
  if countelements(ListST) = 0 then
  begin
    Writeln;
    Writeln('Empty List of Sweets Types :(');
  end
  else
  begin
    Randomize;
    Writeln;
    Writeln('Enter name of Present');
    Readln(nameof);
    Temp := list;
    temp2 := list2;
    while Temp^.adr <> nil do
      Temp := Temp^.adr;

    new(Temp^.adr);
    Temp := Temp^.adr;
    Temp.name := nameof;
    Temp.ID := q;
    inc(q);
    Temp^.adr := nil;

    kek := Random(countelements(ListST));
    SetLength(Temp.Info, kek);
    Temp^.SummTypes := kek;

    summWeight := 0;
    summSCount := 0;

    for counter := 0 to kek - 1 do
    begin
      Randomize;
      ranIndex := Random(kek);
      if ranIndex = 0 then
        Inc(ranIndex);
      while (temp2.adr <> nil) and (temp2.adr.Info.IDs <> ranIndex) do
      begin
        temp2 := temp2.Adr;
      end;
      //if temp2<> nil then Break;

      Temp^.Info[counter].NameTypes := temp2.Info.NameTypes;
      Temp^.Info[counter].value := temp2.Info.Value;
      Temp^.Info[counter].weight := temp2.Info.weight;
      Temp^.Info[counter].sugarc := temp2.Info.SugarC;
      Temp^.Info[counter].SweetId := temp2.Info.SweetId;
      Temp^.Info[counter].IDs := counter;
      summWeight := summWeight + strtoint(temp2.Info.weight);
      summSCount := summSCount + temp2.Info.SugarC;

    end;
    Temp.SummWeight := summWeight;
    Temp.SummSCount := summSCount;
  end;
end;

procedure WriteListPresents(const List: TPNYPresents);
var
  temp: TPNYPresents;
  kek1, counter2: Byte;
begin
  temp := List;
  if temp^.adr = nil then
    write('       Empty List    ')
  else
    while temp^.adr <> nil do
    begin
      temp := temp^.Adr;
      Writeln;
      Writeln('___________________________________________________________________________');
      Writeln('ID      |    Name   |   Summ Weight |  Summ Sugar Count   ');
      writeln;
      Writeln(temp.id: 4, '  ', temp.name: 10, '         ', temp.summweight: 4, '          ', temp.summscount: 4);
      kek1 := Length(temp.info);
      writeln;
      Writeln('   ID    |    Sweet    | Sweet Type Name |   Value   |   Weight  |   Sugar   ');
      Writeln('_____________________________________________________________________________');
      for counter2 := 0 to kek1 - 1 do
      begin
        Writeln(temp.info[counter2].ids: 4, '', getnameofsweet(ListS, temp.info[counter2].sweetid): 15, '', temp.info[counter2].nametypes: 20, '     ', temp.info[counter2].value: 4, '        ', temp.info[counter2].weight: 4, '           ', temp.info[counter2].sugarc: 4);
      end;
    end;
end;

procedure createpresent;
var
  k10: string;
begin
  repeat
    Writeln;
    Writeln('Create one more Present: 1');
    Writeln('Exit in NY Menu: 2');
    Readln(k10);
    val(k10, lel, r);
    if lel = 1 then
    begin
      case lel of
        1:
          begin
            Generate(ListP, ListST);

          end;
      end;
    end
    else
      Writeln;
    Writeln('Try again');

  until lel = 2;

end;

procedure CreateNYPresents;
var
  test: Byte;
  k9: string;
begin
  repeat
    writeln;
    Writeln('Create NY Presents: 1');
    Writeln('Show NY Presents: 2');
    Writeln('Exit in main menu: 3');
    Writeln('_____________________');
    Writeln;
    Readln(k9);
    val(k9, lel, r);
    if lel in [1..2] then
    begin
      case lel of
        1:
          begin
            createpresent;
          end;
        2:
          begin
            //SortBublInf(ListP);
            sortSCount(ListP);
            WriteListPresents(Listp);
          end;
      end;
    end
    else
    begin
      Writeln;
      Writeln('Please, try again ');
    end;
  until lel = 3;
end;

begin
  Randomize;
  i := 0;
  j := 0;
  q := 0;
  New(ListS);
  ListS.Info.Id := -1;
  New(ListSt);
  ListST.Info.IDs := -1;
  New(ListP);
  SetLength(Listp.Info, 1);
  ListP.Info[q].IDs := 1;
  repeat
    Writeln;
    Writeln('________________________________');
    Writeln;
    writeln('Press 1 Show Lists: ');
    Writeln('Press 2 Edit Lists: ');
    Writeln('Press 3 to Create NY Presents: ');
    Writeln('Press 4 to Exit:');
    Writeln('________________________________');
    Writeln;
    readln(k);
    val(k, lel, r);
    if (lel in [1..4]) then
    begin
      case lel of

        1:
          begin
            kek := -1;
            ShowLists;
          end;
        2:
          begin
            EditLists;

          end;
        3:
          begin
            CreateNYPresents;
          end;

      end;
    end
    else
    begin
      Writeln;
      Writeln('Please, try again ');
    end;
  until lel = 4;
  writeln('Press enter...');
  Readln;
end.

