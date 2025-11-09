Table 50063 "Emp Department-pb"
{
    DrillDownPageID = "Employee Department";
    LookupPageID = "Employee Department";

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*IF Code<>xRec.Code THEN BEGIN
                  SalesSetup.GET;
                 // NoSeriesMgt.TestManual(SalesSetup."Employee Department");
                  "No. Series":='';
                  NoSeriesMgt.SetSeries(Code);
                  END;
                  */

            end;
        }
        field(2; "Dept Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "No. Series"; Code[30])
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
    }

    keys
    {
        key(Key1; "Code", "Dept Name")
        {
            Clustered = true;
        }
        key(Key2; "Dept Name")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*IF Code='' THEN BEGIN
          //SalesSetup.GET;
          //SalesSetup.TESTFIELD("Employee Department");
          //NoSeriesMgt.InitSeries(SalesSetup."Employee Department",xRec."No. Series",0D,Code,"No. Series");
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

