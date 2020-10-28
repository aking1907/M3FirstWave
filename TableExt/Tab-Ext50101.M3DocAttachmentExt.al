tableextension 50101 "M3 Doc. Attachment Ext." extends "Document Attachment"
{
    fields
    {
        field(50000; "Record ID"; RecordId)
        {
            Caption = 'Record ID';
            DataClassification = ToBeClassified;
        }
    }

    var
        FileMgt: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";

    procedure ImportFileToBLOB(RecID: RecordId)
    var
        FileName: Text;
        DocInStream: InStream;
        DocOutStream: OutStream;
        InputRecordID: RecordId;
        RecRef: RecordRef;
    begin
        if RecRef.Get(RecID) then begin
            "Record ID" := RecID;
            "Table ID" := RecRef.Number;          
        end;

        FileName := FileMgt.BLOBImport(TempBlob, 'File');
        if FileName = '' then
            exit;

        "File Name" := FileName;
        Validate("File Extension", FileMgt.GetExtension(FileName));
        TempBlob.CreateInStream(DocInStream, TextEncoding::UTF8);
        "Document Reference ID".ImportStream(DocInStream, '');

        if not Insert(true) then
            Modify(true);
    end;

    procedure ExportBlobToFile()
    var
        DocInStream: InStream;
        DocOutStream: OutStream;
    begin
        TempBlob.CreateOutStream(DocOutStream, TextEncoding::UTF8);
        "Document Reference ID".ExportStream(DocOutStream);
        FileMgt.BLOBExport(TempBlob, "File Name", true);
    end;
}
