### Simple usage till now

```
DataCrumbs::Builder.new(input: "my ball is on the tree", warehouse: Warehouse.find(3)).embed_and_create!
AiFeatures::Knowledge.new.answer_question(question: "Where's my ball dude?")
```


### Grape tips

To return routes:
`rake grape:routes`
