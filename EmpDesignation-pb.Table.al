Table 50066 "Emp Designation-pb"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*IF Code<>xRec.Code THEN BEGIN
                  SalesSetup.GET;
                 // NoSeriesMgt.TestManual(SalesSetup."Employee Designation");
                  "No. Series":='';
                  NoSeriesMgt.SetSeries(Code);
                  END;*/

            end;
        }
        field(2; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "No. Series"; Code[30])
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
    }

    keys
    {
        key(Key1; "Code", Name)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*IF Code='' THEN BEGIN
          SalesSetup.GET;
         // SalesSetup.TESTFIELD("Employee Designation");
         // NoSeriesMgt.InitSeries(SalesSetup."Employee Designation",xRec."No. Series",0D,Code,"No. Series");
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

