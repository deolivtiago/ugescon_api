defmodule Api.Accounting.FinancialStatement.List do
  @moduledoc false

  alias Api.Repo
  alias Ecto.Adapters.SQL

  @doc false
  def call(person_id) do
    Repo
    |> SQL.query!(raw_sql(), [Ecto.UUID.dump!(person_id)])
    |> merge_result()
  end

  defp merge_result(result), do: Enum.map(result.rows, &into_map(result.columns, &1))

  defp into_map([k1 | [k2 | [k3 | [k4 | []]]]], [v1 | [v2 | [v3 | [v4 | []]]]]),
    do: Map.new([{k1, v1}, {k2, v2}, {k3, v3}, {k4, v4}], fn {k, v} -> {String.to_atom(k), v} end)

  defp raw_sql do
    "select t.level, t.code, t.name, sum(t.total) as total
from (
    (
      -- lvl4
      -- debit
      select s.level,
        s.code,
        (
          select name
          from accounts a
          where a.code = s.code
        ) as name,
        sum(s.total) as total
      from (
          (
            -- debit (+)
            select 4 as level,
              a.code,
              coalesce(sum(e.value), 0) as total
            from entries e
              right join accounts a on e.debit_account_code = a.code
            where a.type = 0
              and a.level in (4)
              and coalesce(e.person_id, $1) = $1
            group by code
            order by code,
              level
          )
          union
          (
            -- debit (-)
            select 4 as level,
              a.code,
              coalesce(0 - sum(e.value), 0) as total
            from entries e
              right join accounts a on e.credit_account_code = a.code
            where a.type = 0
              and a.level in (4)
              and coalesce(e.person_id, $1) = $1
            group by code
            order by code,
              level
          )
        ) s
      group by s.code,
        s.level
      order by s.code,
        s.level
    )
    union
    (
      -- lvl4
      -- credit
      select s.level,
        s.code,
        (
          select name
          from accounts a
          where a.code = s.code
        ) as name,
        sum(s.total) as total
      from (
          (
            -- credit (+)
            select 4 as level,
              a.code,
              coalesce(sum(e.value), 0) as total
            from entries e
              right join accounts a on e.credit_account_code = a.code
            where a.type = 1
              and a.level in (4)
              and coalesce(e.person_id, $1) = $1
            group by code
            order by code,
              level
          )
          union
          (
            -- credit (-)
            select 4 as level,
              a.code,
              coalesce(0 - sum(e.value), 0) as total
            from entries e
              right join accounts a on e.debit_account_code = a.code
            where a.type = 1
              and a.level in (4)
              and coalesce(e.person_id, $1) = $1
            group by code
            order by code,
              level
          )
        ) s
      group by s.code,
        s.level
      order by s.code,
        s.level
    )
    union
    (
      -- lvl3
      -- debit
      select s.level,
        s.code,
        (
          select name
          from accounts a
          where a.code = s.code
        ) as name,
        sum(s.total) as total
      from (
          (
            -- debit (+)
            select 3 as level,
              substring(a.code, 1, 3) as code,
              coalesce(sum(e.value), 0) as total
            from entries e
              right join accounts a on e.debit_account_code = a.code
            where a.type = 0
              and a.level in (4)
              and coalesce(e.person_id, $1) = $1
            group by code
            order by code,
              level
          )
          union
          (
            -- debit (-)
            select 3 as level,
              substring(a.code, 1, 3) as code,
              coalesce(0 - sum(e.value), 0) as total
            from entries e
              right join accounts a on e.credit_account_code = a.code
            where a.type = 0
              and a.level in (4)
              and coalesce(e.person_id, $1) = $1
            group by code
            order by code,
              level
          )
        ) s
      group by s.code,
        s.level
      order by s.code,
        s.level
    )
    union
    (
      -- lvl3
      -- credit
      select s.level,
        s.code,
        (
          select name
          from accounts a
          where a.code = s.code
        ) as name,
        sum(s.total) as total
      from (
          (
            -- credit (+)
            select 3 as level,
              substring(a.code, 1, 3) as code,
              coalesce(sum(e.value), 0) as total
            from entries e
              right join accounts a on e.credit_account_code = a.code
            where a.type = 1
              and a.level in (4)
              and coalesce(e.person_id, $1) = $1
            group by code
            order by code,
              level
          )
          union
          (
            -- credit (-)
            select 3 as level,
              substring(a.code, 1, 3) as code,
              coalesce(0 - sum(e.value), 0) as total
            from entries e
              right join accounts a on e.debit_account_code = a.code
            where a.type = 1
              and a.level in (4)
              and coalesce(e.person_id, $1) = $1
            group by code
            order by code,
              level
          )
        ) s
      group by s.code,
        s.level
      order by s.code,
        s.level
    )
    union
    (
      -- lvl2
      -- debit
      select s.level,
        s.code,
        (
          select name
          from accounts a
          where a.code = s.code
        ) as name,
        sum(s.total) as total
      from (
          (
            -- debit (+)
            select 2 as level,
              substring(a.code, 1, 2) as code,
              coalesce(sum(e.value), 0) as total
            from entries e
              right join accounts a on e.debit_account_code = a.code
            where a.type = 0
              and a.level in (4)
              and coalesce(e.person_id, $1) = $1
            group by code
            order by code,
              level
          )
          union
          (
            -- debit (-)
            select 2 as level,
              substring(a.code, 1, 2) as code,
              coalesce(0 - sum(e.value), 0) as total
            from entries e
              right join accounts a on e.credit_account_code = a.code
            where a.type = 0
              and a.level in (4)
              and coalesce(e.person_id, $1) = $1
            group by code
            order by code,
              level
          )
        ) s
      group by s.code,
        s.level
      order by s.code,
        s.level
    )
    union
    (
      -- lvl2
      -- credit
      select s.level,
        s.code,
        (
          select name
          from accounts a
          where a.code = s.code
        ) as name,
        sum(s.total) as total
      from (
          (
            -- credit (+)
            select 2 as level,
              substring(a.code, 1, 2) as code,
              coalesce(sum(e.value), 0) as total
            from entries e
              right join accounts a on e.credit_account_code = a.code
            where a.type = 1
              and a.level in (4)
              and coalesce(e.person_id, $1) = $1
            group by code
            order by code,
              level
          )
          union
          (
            -- credit (-)
            select 2 as level,
              substring(a.code, 1, 2) as code,
              coalesce(0 - sum(e.value), 0) as total
            from entries e
              right join accounts a on e.debit_account_code = a.code
            where a.type = 1
              and a.level in (4)
              and coalesce(e.person_id, $1) = $1
            group by code
            order by code,
              level
          )
        ) s
      group by s.code,
        s.level
      order by s.code,
        s.level
    )
    union
    (
      -- lvl1
      -- debit
      select s.level,
        s.code,
        (
          select name
          from accounts a
          where a.code = s.code
        ) as name,
        sum(s.total) as total
      from (
          (
            -- debit (+)
            select 1 as level,
              substring(a.code, 1, 1) as code,
              coalesce(sum(e.value), 0) as total
            from entries e
              right join accounts a on e.debit_account_code = a.code
            where a.type = 0
              and a.level in (4)
              and coalesce(e.person_id, $1) = $1
            group by code
            order by code,
              level
          )
          union
          (
            -- debit (-)
            select 1 as level,
              substring(a.code, 1, 1) as code,
              coalesce(0 - sum(e.value), 0) as total
            from entries e
              right join accounts a on e.credit_account_code = a.code
            where a.type = 0
              and a.level in (4)
              and coalesce(e.person_id, $1) = $1
            group by code
            order by code,
              level
          )
        ) s
      group by s.code,
        s.level
      order by s.code,
        s.level
    )
    union
    (
      -- lvl1
      -- credit
      select s.level,
        s.code,
        (
          select name
          from accounts a
          where a.code = s.code
        ) as name,
        sum(s.total) as total
      from (
          (
            -- credit (+)
            select 1 as level,
              substring(a.code, 1, 1) as code,
              coalesce(sum(e.value), 0) as total
            from entries e
              right join accounts a on e.credit_account_code = a.code
            where a.type = 1
              and a.level in (4)
              and coalesce(e.person_id, $1) = $1
            group by code
            order by code,
              level
          )
          union
          (
            -- credit (-)
            select 1 as level,
              substring(a.code, 1, 1) as code,
              coalesce(0 - sum(e.value), 0) as total
            from entries e
              right join accounts a on e.debit_account_code = a.code
            where a.type = 1
              and a.level in (4)
              and coalesce(e.person_id, $1) = $1
            group by code
            order by code,
              level
          )
        ) s
      group by s.code,
        s.level
      order by s.code,
        s.level
    )
  ) t
group by t.level, t.code, t.name
order by t.code,
  t.level
"
  end
end
