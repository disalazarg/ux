include ApplicationHelper
p = Product.includes(answer: [picks: [alternative: :question]], answers: [picks: [alternative: :question]]).find(1)
p p.answer.to_datapoint
p p.answers.external.map &:to_datapoint
p prepare_gauge p.answer, p.answers.external