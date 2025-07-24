local marks = require('marko.marks')
local config = require('marko.config')

describe('marko', function()
  before_each(function()
    vim.cmd('enew!')
    vim.api.nvim_buf_set_lines(0, 0, -1, false, {'one', 'two', 'three'})
  end)

  it('collects buffer marks', function()
    vim.cmd('normal! ma')
    local m = marks.get_buffer_marks()
    assert.are.equal(1, #m)
    assert.are.equal('a', m[1].mark)
    assert.are.equal(1, m[1].line)
  end)

  it('deduplicates marks preferring buffer mark', function()
    local data = {
      { mark = 'a', line = 1, col = 0, type = 'buffer', filename = 'f' },
      { mark = 'A', line = 1, col = 0, type = 'global', filename = 'f' },
    }
    local dedup = marks.deduplicate_marks(data)
    assert.are.equal(1, #dedup)
    assert.are.equal('buffer', dedup[1].type)
  end)

  it('applies user config', function()
    config.setup({ width = 123 })
    assert.are.equal(123, config.get().width)
  end)
end)
