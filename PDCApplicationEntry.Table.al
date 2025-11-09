Table 50003 "PDC Application Entry"
{
    DrillDownPageID = "PDC Application Entry";
    LookupPageID = "PDC Application Entry";

    fields
    {
        field(1; "PDC Entry No."; Integer)
        {
            Editable = false;
        }
        field(2; "Cust Ledger Entry No."; Integer)
        {
            BlankZero = true;
            Editable = false;
            NotBlank = true;
        }
        field(3; "Amount to Apply"; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                /*IF xRec."Amount to Apply" <> "Amount to Apply" THEN
                  BEGIN
                    PDCEntry.GET("PDC Entry No.");
                    PDCEntry.CALCFIELDS(PDCEntry."PDC Amount Applied");
                    IF (PDCEntry."PDC Amount Applied" + "Amount to Apply" - xRec."Amount to Apply") > PDCEntry."PDC Amount" THEN
                      ERROR(Text001,(PDCEntry."PDC Amount" - PDCEntry."PDC Amount Applied"));
                
                    CustLedgEntry.GET("Cust Ledger Entry No.");
                    CustLedgEntry.CALCFIELDS(CustLedgEntry."Remaining Amount",CustLedgEntry."PDC Unposted Amount");
                    IF (CustLedgEntry."PDC Unposted Amount" + "Amount to Apply" - xRec."Amount to Apply") > CustLedgEntry."Remaining Amount" THEN
                      ERROR(Text001,(CustLedgEntry."Remaining Amount" - CustLedgEntry."PDC Unposted Amount"));
                  END;
                 */

            end;
        }
        field(4; "Customer No."; Code[20])
        {
            Editable = false;
        }
        field(5; "Document Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(6; "Document No."; Code[20])
        {
            Editable = false;
        }
        field(7; "Document Date"; Date)
        {
            Editable = false;
        }
        field(8; "Due Date"; Date)
        {
            Editable = false;
        }
        field(9; "External Doc. No."; Code[20])
        {
        }
        field(10; "Item Detail"; Text[60])
        {
            CalcFormula = min("Purch. Inv. Line".Description where("Document No." = field("Document No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "PDC Entry No.", "Cust Ledger Entry No.")
        {
            Clustered = true;
            SumIndexFields = "Amount to Apply";
        }
        key(Key2; "Customer No.")
        {
            SumIndexFields = "Amount to Apply";
        }
    }

    fieldgroups
    {
    }

    var
        PDCEntry: Record PDC;
        CustLedgEntry: Record "Cust. Ledger Entry";
        Text001: label 'Maximum Additional Amount to apply is %1. Please check the entry.';
}

