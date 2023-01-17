-- require(tidyverse)
-- require(other)

-- htor.sexoutputs <- rbind(
--   url.H2R.CEFL %>% GetRawGORSData(filename = "H2R CEFL outputs", update = update),
--   url.H2R.MSW %>% GetRawGORSData(filename = "H2R MSW outputs", update = update)
-- ) %>%
--   rename(Actuals.Targets = `Actuals/Targets`,
--          AreaOffice = `Organisation unit`) %>%
--   mutate_if(is.character,
--             factor) %>%
--   merge(htorCRL, by.x = "AreaOffice", by.y = "Organisation.unit") %>%
--   mutate(H2R = Value * H2R,
--          NonH2R = Value * NonH2R) %>%
--   merge(CRL, by.x = "Org.unit.Country", by.y = "Organisation.unit") %>%
--   select(-Org.unit.Country, -Value) %>%
--   merge(indicators) %>%
--   mutate(Modality = factor(Modality, levels = c(Modalities, "", "(unspecified)")))

local chars = "%,+("

local get_line = function(line_num)
    return vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, true)[1]
end

local a = require("plenary").busted

-- a.describe("get_line", function ()
--     a.it("blank line", function ()
--         assert.equals("", get_line(3))
--     end)
--     a.it("line 4", function ()
--         assert.equals("-- htor.sexoutputs <- rbind(", get_line(4))
--     end)
-- end)


local is_line_blank = function(line)
    return line == ""
end

-- a.describe("is_line_blank", function()
--     a.it("blank line", function()
--         assert.equals(true, is_line_blank(get_line(3)))
--     end)
--     a.it("non-blank", function()
--         assert.equals(false, is_line_blank(get_line(4)))
--     end)
-- end)

local get_first_non_blank_char = function(s)
    -- function to return the first non-blank character in a string
    local first_char = 1
    while (string.sub(s, first_char, first_char) == " " or string.sub(s, first_char, first_char) == "-") do
    -- this should use the line below, but whilst testing in a lua file, i am excluding comment strings
    -- while string.sub(s, first_char, first_char) == " "  do
        first_char = first_char + 1
    end
    return string.sub(s, first_char, first_char)
end

-- a.describe("get_first_non_blank_char", function()
--     a.it("line 7, should be )", function ()
--         assert.equals(")", get_first_non_blank_char(get_line(7)))
--     end)
--     a.it("line 6, should be u", function ()
--         assert.equals("u", get_first_non_blank_char(get_line(6)))
--     end)
-- end)

local get_last_non_blank_char = function(s)
    -- function to return the last non-blank character in a string
    local last_char = -1
    while string.sub(s, last_char, last_char) == " " do
        last_char = last_char - 1
    end
    return string.sub(s, last_char, last_char)
end

local does_line_start_with_bracket = function(line)
    local first_char = get_first_non_blank_char(line)
    if (string.find(")}]", first_char, 1, true)) then
        return true
    end
    return false
end

-- a.describe("start with bracket", function()
--     a.it("line 7, should be true", function ()
--         assert.equals(true, does_line_start_with_bracket(get_line(7)))
--     end)
--     a.it("line 6, should be false", function ()
--         assert.equals(false, does_line_start_with_bracket(get_line(6)))
--     end)
-- end)

local does_line_end_with_char = function(line)
    local last_char = get_last_non_blank_char(line)
    if (string.find(chars, last_char, 1, true)) then
        return true
    end
    return false
end

local add_col_refs = function(from_line, to_line)
    local from = {
        line = from_line,
        col = 1
    }
    local to = {
        line = to_line,
        col = 0
    }
    print("to line is "..to_line)
    to.col = string.len(get_line(to_line))
    return { from = from, to = to }
end

local search_backwards = function(line_num)
    local still_testing = 1
    local from_line = line_num
    local test_line = line_num - 1

    local from_line_content = get_line(from_line)

    if is_line_blank(from_line_content) then
        return from_line
    end

    if does_line_start_with_bracket(from_line_content) then
        from_line = from_line - 1
        test_line = from_line - 1
    end

    while still_testing == 1 do
        local line_content = get_line(test_line)
        from_line_content = get_line(from_line)
        if is_line_blank(line_content) then
            test_line = test_line - 1
        elseif does_line_end_with_char(line_content) then
            from_line = test_line
            test_line = test_line - 1
        elseif does_line_start_with_bracket(from_line_content) then
            from_line = test_line
            test_line = test_line - 1
        else
            still_testing = 0
        end
    end
    return from_line
end

a.describe("search_backwards", function ()
    a.it("line 4", function ()
        assert.equals(4, search_backwards(4))
    end)
    a.it("line 5", function ()
        assert.equals(4, search_backwards(5))
    end)
    a.it("line 6", function ()
        assert.equals(4, search_backwards(6))
    end)
    a.it("line 7", function ()
        assert.equals(4, search_backwards(7))
    end)
end)

local get_line_range = function()
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
    local line_to_test = cursor_line

    -- search backwards
    -- search forwards
end


-- local r = function(line_num)
--
--     -- local current_line = vim.api.nvim_win_get_cursor(0)[1]
--     local cursor_line = line_num
--     local line_to_test = cursor_line
--     local from = cursor_line
--     local to = cursor_line
--
--     while does_line_start_with_bracket(line_to_test) or does_line_end_with_char(line_to_test) or (get_line(line_to_test) == "") do
--         if(get_line(line_to_test)) ~= "" then
--             from= line_to_test
--         end
--         line_to_test = line_to_test - 1
--     end
--     line_to_test = cursor_line
--     while does_line_end_with_char(line_to_test) or does_line_start_with_bracket(line_to_test) or (get_line(line_to_test) == "") do
--         print("testing "..line_to_test.." forward")
--         if(get_line(line_to_test)) ~= "" then
--             to = line_to_test
--         end
--         line_to_test = line_to_test + 1
--     end
--
--     return { from , to }
-- end

local r = function(line_num)
    local from_line, to_line = unpack(r(line_num))
    return add_col_refs(from_line, to_line)
end

-- print(vim.inspect(r(3)))
-- 1 should return 1, and does
-- 2 should return 2, and does
-- 3 is a blank line, but returns 3 to 5
-- 4 should return 4 to 18, but returns 4 to 5
-- 5 returns 4 to 5
-- 6 returns just line 6
-- 7 returns 7 to 17 (not 18), as do the others in that range
-- 18 returns just line 18
-- so somehow I need to work out how to reconfirm that the lines I've tested are good, and then recopy that into the return string

