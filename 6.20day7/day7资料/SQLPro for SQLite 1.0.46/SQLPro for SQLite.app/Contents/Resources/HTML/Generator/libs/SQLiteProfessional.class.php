<?php
class SQLDataType
{
    const String = 0;
    const Number = 1;
    const Binary = 2;
}

class SQLTableColumn
{
    function __construct($columnName, $dataType)
    {
        $this->name     = $columnName;
        $this->dataType = $dataType;
    }

    public function getName()
    {
        return $this->name;
    }

    public function setName($columnName)
    {
        $this->name = $columnName;
    }

    public function getDataType()
    {
        return $this->dataType;
    }
} // End of SQLTableColumn

class SQLTable
{
    function __construct($tableName)
    {
        $this->name = $tableName;
        $this->columns = array();
    }

    public function getColumns()
    {
        return (array)$this->columns;
    } // End of getColumns

    public function setColumns($newColumns)
    {
        $this->columns = $newColumns;
    }

    public function addColumn($columnName)
    {
        $newColumn = new SQLTableColumn($columnName);
        array_push($this->columns, $newColumn);
    } // End of addColumn
} // End of SQLTable
?>
