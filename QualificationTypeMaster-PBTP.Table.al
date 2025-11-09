Table 50055 "Qualification Type Master-PBTP"
{

    fields
    {
        field(1; "No."; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                IF "No."<> xRec."No." THEN BEGIN
                
                  SalesSetup.GET;
                  //NoSeriesManagement.TestManual(SalesSetup."Qualification No. Series");
                  NoSeries:='';
                  NoSeriesManagement.SetSeries("No.");
                  END;*/

            end;
        }
        field(2; Qualification; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; NoSeries; Code[30])
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
        key(Key1; "No.", Qualification)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*IF "No."='' THEN BEGIN

         SalesSetup.GET;
      //   SalesSetup.TESTFIELD("Qualification No. Series");
        // NoSeriesManagement.InitSeries(SalesSetup."Qualification No. Series",xRec.NoSeries,0D,"No.",NoSeries);
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
        NoSeriesManagement: Codeunit NoSeriesManagement;
}

