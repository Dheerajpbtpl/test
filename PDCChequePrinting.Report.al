/// <summary>
/// Report PDC Cheque Printing (ID 50059).
/// </summary>
Report 50059 "PDC Cheque Printing"
{
    RDLCLayout = './Layouts/PDCChequePrinting.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(PDC; PDC)
        {
            column(ChequePrintName_PDC; PDC."Cheque Print Name")
            {
            }
            column(Name_PDC; PDC.Name)
            {
            }
            column(PDCReceivedDate_PDC; PDC."PDC Received Date")
            {
            }
            column(PDCChequeDate_PDC; PDC."PDC Cheque Date")
            {
            }
            column(PDCAmount_PDC; PDC."PDC Amount")
            {
            }
            column(Numbertext; Numbertext[1])
            {
            }
            column(Numbertext2; Numbertext[2])
            {
            }
            trigger OnAfterGetRecord();
            begin
                BearerName := '';
                GLEntry.SetRange(GLEntry."Posting Date", PDC."PDC Received Date");
                LedgAmount := Abs(PDC."PDC Amount");
                ReportCheck.InitTextVariable;
                ReportCheck.FormatNoText(Numbertext, LedgAmount, PDC."Currency Code");
                GLEntry.Reset;
                GLEntry.SetRange(GLEntry."Source No.", PDC."Account No.");
                GLEntry.SetRange(GLEntry."Posting Date", PDC."PDC Received Date");
                //GLEntry.SETFILTER(GLEntry."Source Type",'<>%1',GLEntry."Source Type"::"Bank Account");
                if GLEntry.FindFirst then begin
                    repeat
                        if GLEntry."Source Type" = GLEntry."source type"::Vendor then begin
                            if vendor.Get(GLEntry."Source No.") then begin
                                BearerName := vendor.Name;
                            end;
                        end;
                        if GLEntry."Source Type" = GLEntry."source type"::Customer then begin
                            if Customer.Get(GLEntry."Source No.") then begin
                                BearerName := Customer.Name;
                            end;
                        end;
                    until (GLEntry.Next = 0) or (BearerName <> '');
                end;
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
        Numbertext: array[5] of Text[200];
        ReportCheck: Report Check;
        Dayint: Integer;
        Monthint: Integer;
        Yearint: Integer;
        Daytext: Text[4];
        Monthtext: Text[4];
        yeartext: Text[4];
        Text1: Text;
        vendor: Record Vendor;
        Customer: Record Customer;
        BearerName: Text[100];
        LedgAmount: Decimal;
        Text2: Text;
        GLEntry: Record "G/L Entry";
        BankAccount: Record "Bank Account";
        BankName: Text;
        DimSetEntry: Record "Dimension Set Entry";
        numbertxt: Text[150];


}
