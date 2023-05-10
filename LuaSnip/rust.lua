return {
  s({ trig = "fn" },
    fmt(
      [[
        fn {}({}) -> {} {{
          {}
        }}
      ]],
      {
        i(1, "function_name"),
        i(2, ""),
        i(3, "()"),
        i(0, "todo!()"),
      }
    )
  ),
}
