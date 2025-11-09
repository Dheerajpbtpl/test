Table 50054 "Payroll Setup-PBTPL"
{

    fields
    {
        field(1; "Primary key"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code where(Code = filter('EMPV'));

            trigger OnValidate()
            begin
                /*IF "Primary key"<>xRec."Primary key" THEN BEGIN
                 SalesSetup.GET;
                 //NoSeriesMgt.TestManual(SalesSetup."Payroll Setup");
                 "No. Series":='';
                 NoSeriesMgt.SetSeries("Primary key");
                 END;
                 */

            end;
        }
        field(2; "Dearness Allowance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "House Rent Allowance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Conveyance Allowance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Leave Travel Allowance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Medical Allowance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Books and Periodicals"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Gratuity; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Employee Provident Fund"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Professional Tax"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Perquisites; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; ESIC; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; EmpID; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Created Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Created By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Modify Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Modified By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "No. Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(19; Column1; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Salary Journal Batch Name"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name;
        }
        field(21; "Salary Journal Template Name"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name;
        }
        field(22; "ESI Applicable Amount Upto"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "ESI %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "PF Applicable Amount Upto"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "PF %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "PF G/L Account No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(27; "PF Bal Account No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(28; "ESI G/L Account No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(29; "ESI Bal Account No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(30; "Worker Working Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Employee Working Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(32; OvertimeGlAcc; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(33; OvertimeBalGlAcc; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(34; "Employee No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
    }

    keys
    {
        key(Key1; "Primary key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        /*IF "Primary key"='' THEN BEGIN
          SalesSetup.GET;
        //  SalesSetup.TESTFIELD("Payroll Setup");
          //NoSeriesMgt.InitSeries(SalesSetup."Payroll Setup",xRec."Primary key",0D,"Primary key","No. Series");
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

