/// <summary>
/// Report Contacts Import (ID 50120).
/// </summary>
/// Taneesh
/*Report 50120 "Contacts Import"
{
    RDLCLayout = './Layouts/ContactsImport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = where(Number = const(1));
            trigger OnAfterGetRecord();
            begin
                if ImportContacts.FindLast then
                    EntryNo := ImportContacts."Entry No."
                else
                    EntryNo := 1;
                if FileLoc = '' then
                    exit;
               // if ISCLEAR(ExcelApp) then
                 //   Create(ExcelApp, false, true);
                //ExcelApp.Visible(TRUE);
                Book := ExcelApp.Workbooks.Open(FileLoc);
                Book := ExcelApp.ActiveWorkbook;
                Sheet := Book.Worksheets.Item('Contacts Import');
                Sheet.Activate();
                if Sheet.FilterMode then
                    Sheet.ShowAllData;
                NoOfRecords := Sheet.UsedRange.Rows.Count;
                reccount := 1;
                while reccount < NoOfRecords do begin
                    EntryNo += 1;
                    reccount := reccount + 1;
                    ImportContacts.Init;
                    ImportContacts."Company Name" := Format(Sheet.Range('A' + Format(reccount)).Value);
                    ImportContacts.Name := Format(Sheet.Range('B' + Format(reccount)).Value);
                    ImportContacts.Address := Format(Sheet.Range('C' + Format(reccount)).Value);
                    ImportContacts."Address 2" := Format(Sheet.Range('D' + Format(reccount)).Value);
                    ImportContacts."Post Code" := Format(Sheet.Range('E' + Format(reccount)).Value);
                    ImportContacts.City := Format(Sheet.Range('F' + Format(reccount)).Value);
                    ImportContacts.Country := Format(Sheet.Range('G' + Format(reccount)).Value);
                    ImportContacts."Mobile No." := Format(Sheet.Range('H' + Format(reccount)).Value);
                    ImportContacts."Salesperson Code" := Format(Sheet.Range('I' + Format(reccount)).Value);
                    ImportContacts."Contact Group" := Format(Sheet.Range('J' + Format(reccount)).Value);
                    ImportContacts.Email := Format(Sheet.Range('K' + Format(reccount)).Value);
                    ImportContacts."Entry No." := EntryNo;
                    ImportContacts.Insert;
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
                field("File Location"; FileLoc)
                {
                    ApplicationArea = Basic;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        FileLoc := FileManagement.OpenFileDialog('Contact Import', '', '');
                    end;
                }

            }
        }

        actions
        {
        }
    }



    var
        ImportContacts: Record "Import Contacts";
        ExcelApp: Automation Application;
        Range: Automation Range;
     Book: Automation Workbook;
        Sheet: Automation Worksheet;
        FileLoc: Text;
        FileManagement: Codeunit "File Management";
        NoOfRecords: Integer;
        reccount: Integer;
        EntryNo: Integer;

}*/