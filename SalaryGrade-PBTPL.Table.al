Table 50053 "Salary Grade-PBTPL"
{

    fields
    {
        field(1; "Salary Grade Code"; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /* IF "Salary Grade Code"<>xRec."Salary Grade Code" THEN BEGIN
                  SalesSetup.GET;
                 // NoSeriesMgt.TestManual(SalesSetup."Salary Grade");
                  "No. Series":='';
                  //NoSeriesMgt.SetSeries("Salary Grade Code");
                  END;*/

            end;
        }
        field(2; "Salary Grade Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Salary Pay Starting"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Salary Pay To"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Created Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Created By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Modify Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Modified By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "No. Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Salary Grade Code", "Salary Grade Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*IF "Salary Grade Code"='' THEN BEGIN
          SalesSetup.GET;
        //  SalesSetup.TESTFIELD("Salary Grade");
         // NoSeriesMgt.InitSeries(SalesSetup."Salary Grade",xRec."Salary Grade Code",0D,"Salary Grade Code","No. Series");
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
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

