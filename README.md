### Simple usage till now

```
DataCrumbs::Create.new(input: "my ball is on the tree", warehouse: Warehouse.find(3)).embed_and_create
AiFeatures::Knowledge.new.answer_question(question: "Where's my ball dude?")
```
