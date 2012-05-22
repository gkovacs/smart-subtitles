root = exports ? this
print = console.log

applyToneToVowel = (vowel, num) ->
  --num
  if vowel == 'a'
    return ['ā', 'á', 'ǎ', 'à', 'a'][num]
  if vowel == 'i'
    return ['ī', 'í', 'ǐ', 'ì', 'i'][num]
  if vowel == 'e'
    return ['ē', 'é', 'ě', 'è', 'e'][num]
  if vowel == 'o'
    return ['ō', 'ó', 'ǒ', 'ò', 'o'][num]
  if vowel == 'u'
    return ['ū', 'ú', 'ǔ', 'ù', 'u'][num]
  if vowel == 'ü'
    return ['ǖ', 'ǘ', 'ǚ', 'ǜ', 'ü'][num]

getToneNumber = (word) ->
  for c in word
    if c in 'āīēōūǖ'
      return 1
    if c in 'áíéóúǘ'
      return 2
    if c in 'ǎǐěǒǔǚ'
      return 3
    if c in 'àìèòùǜ'
      return 4
  return 5

toneNumberToMarkSingle = (word) ->
  word = word.trim()
  toneNum = word[-1..-1]
  if toneNum in ['1','2','3','4','5']
    toneNum = parseInt(toneNum)
    word = word[...-1]
  else
    return word
  vow = ['a', 'i', 'e', 'o', 'u', 'ü']
  numVowels = (x for x in word when x in vow).length
  if numVowels == 0
    return word
  firstVowel = (x for x in word when x in vow)[0]
  if numVowels == 1 or firstVowel == 'a' or firstVowel == 'o' or firstVowel == 'e'
    return word.replace(firstVowel, applyToneToVowel(firstVowel, toneNum))
  secondVowel = (x for x in word when x in vow)[1]
  return word.replace(secondVowel, applyToneToVowel(secondVowel, toneNum))

toneNumberToMark = (words) ->
  wordL = words.split(' ')
  wordL = (toneNumberToMarkSingle(word) for word in wordL)
  wordL.join(' ')

root.toneNumberToMark = toneNumberToMark
root.getToneNumber = getToneNumber
