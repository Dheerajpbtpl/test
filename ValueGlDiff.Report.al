Report 50092 "Value Gl Diff"
{
    RDLCLayout = './Layouts/ValueGlDiff.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Value Entry"; "Value Entry")
        {
            DataItemTableView = where("Item Ledger Entry Type" = filter(Sale), "Entry Type" = filter("Direct Cost"));
            RequestFilterFields = "Posting Date";
            column(EntryNo_ValueEntry; "Value Entry"."Entry No.")
            {
            }
            column(CostAmountActual_ValueEntry; "Value Entry"."Cost Amount (Actual)")
            {
            }
            column(GLEntryNo; GLEntryNo)
            {
            }
            column(AccNo; GlAcc)
            {
            }
            column(GLAmt; GLAmt)
            {
            }
            trigger OnAfterGetRecord();
            begin
                ValueGLRelation.Reset;
                GLEntryNo := 0;
                GLAmt := 0;
                GlAcc := '';
                ValueGLRelation.SetRange(ValueGLRelation."Value Entry No.", "Value Entry"."Entry No.");
                if ValueGLRelation.FindLast then
                    GLEntryNo := ValueGLRelation."G/L Entry No.";
                GlEntry.SetRange(GlEntry."G/L Account No.", '7190');
                GlEntry.SetRange(GlEntry."Entry No.", GLEntryNo);
                if GlEntry.FindFirst then begin
                    GlAcc := GlEntry."G/L Account No.";
                    GLAmt := GlEntry.Amount;
                end
            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                }
            }
        }

        actions
        {
        }
    }



    var
        ValueGLRelation: Record "G/L - Item Ledger Relation";
        GLEntryNo: Integer;
        GlEntry: Record "G/L Entry";
        GLAmt: Decimal;
        GlAcc: Code[10];

}