Table 50059 "Holidays List-PBTPL"
{

    fields
    {
        field(1; ID; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*IF ID<>xRec.ID THEN BEGIN
                  EmployeeSetup.GET;
                  NoSeriesMgt.TestManual(EmployeeSetup."Employee Nos.");
                  "No. Series":='';
                  NoSeriesMgt.SetSeries(ID);
                  END;*/

            end;
        }
        field(2; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Created Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Created By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Modify Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Modified By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "No. Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Date)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin


        /*IF ID='' THEN BEGIN
          EmployeeSetup.GET;
          EmployeeSetup.TESTFIELD("Holiday List");
          NoSeriesMgt.InitSeries(EmployeeSetup."Holiday List",xRec.ID,0D,ID,"No. Series");
          END;*/


        "Created By" := UserId;
        "Created Date" := CurrentDatetime;

    end;

    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modify Date" := CurrentDatetime;
    end;

    var
        EmployeeSetup: Record "SMS Body Template-PBTPL";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

