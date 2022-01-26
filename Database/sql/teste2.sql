USE PI;

SET @os ='[
    {
        "id": "66",
        "date_end": "2022-01-09 18:00:00",
        "occupied": "1",
        "date_begin": "2022-01-09 17:30:00",
        "idCategory": "[1,2,3]",
        "date_requested": "2022-01-02 14:59:27"
    },
    {
        "id": "39",
        "date_end": "2022-01-03 11:30:00",
        "occupied": "1",
        "date_begin": "2022-01-03 08:00:00",
        "idCategory": "3",
        "date_requested": "2022-01-01 22:40:58"
    }
]';

SET @test ='
    {
        "id": "39",
        "date_end": "2022-01-03 11:30:00",
        "occupied": "1",
        "date_begin": "2022-01-03 08:00:00",
        "idCategory": "3",
        "date_requested": "2022-01-01 22:40:58"
    }';

SET @new_os = (
select json_pretty(json_arrayagg(os.js)) as new_os
from json_table(@os, '$[*]' columns (js json path '$')) as os
where not exists (
  select 1
  from json_table(@test, '$' columns ( js json path '$')) as tst
  where json_extract(os.js, '$.id') = json_extract(tst.js, '$.id')
    and json_extract(os.js, '$.date_end') = json_extract(tst.js, '$.date_end')
    and json_extract(os.js, '$.date_begin') = json_extract(tst.js, '$.date_begin')
    and json_extract(os.js, '$.date_requested') = json_extract(tst.js, '$.date_requested')
    and json_extract(os.js, '$.idCategory') = json_extract(tst.js, '$.idCategory')
    and json_extract(os.js, '$.occupied') = json_extract(tst.js, '$.occupied')
));

SELECT @os,@new_os;