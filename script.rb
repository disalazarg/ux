include ApplicationHelper
p = Product.includes(answer: [picks: [alternative: :question]], answers: [picks: [alternative: :question]]).first
p prepare_gauge p.answer, p.answers