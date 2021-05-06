
#!/usr/bin/python
# -*- coding: utf-8 -*-

import xlutils.copy
import xlrd

def loadData(filepath):
    data = xlrd.open_workbook(filepath)
    table = data.sheet_by_index(0)
    result = []
    for r in range(table.nrows):
        person = {}
        person["id"] = table.row(r)[3].value
        person["account"] = table.row(r)[15].value
        print(person)
        result.append(person)
    return result

def query(source, value):
    for person in source:
        if person["id"] == value:
            return person["account"]
    return ""

def writeData():
    data = xlrd.open_workbook(r"./700.xlsx")
    table = data.sheet_by_index(0)
    ws = xlutils.copy.copy(data)
    source = loadData("./1-26.xlsx")

    for r in range(table.nrows):
        card = table.row(r)[5].value
        tab=ws.get_sheet(0)
        account = query(source,card)
        tab.write(r,11,account)
    ws.save(r"./700.xlsx")

if __name__=="__main__":
    writeData()
