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


CALL get_sp_horarios(53);




SET @nonSorted = '[
    {
        "id": "119",
        "date_end": "2022-01-04 18:30:00",
        "occupied": "0",
        "date_begin": "2022-01-04 16:00:00",
        "idCategory": "2",
        "date_requested": "2022-01-01 11:14:39"
    },
    {
        "id": "134",
        "date_end": "2022-01-06 11:30:00",
        "occupied": "0",
        "date_begin": "2022-01-06 08:00:00",
        "idCategory": "4",
        "date_requested": "2022-01-02 16:15:49"
    },
    {
        "id": "142",
        "date_end": "2022-01-09 11:00:00",
        "occupied": "1",
        "date_begin": "2022-01-09 08:30:00",
        "idCategory": "4",
        "date_requested": "2022-01-01 18:11:20"
    }
]';


SELECT JSON_ARRAYAGG(object)
FROM (
    SELECT object
    FROM JSON_TABLE(@nonSorted,
                    '$[*]' COLUMNS (object JSON PATH '$',
                                    date_requested DATETIME PATH '$.date_requested')) jsontable
    ORDER BY date_requested LIMIT 18446744073709551615
) parsed;