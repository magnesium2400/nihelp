function scatterAlpha(alpha)
    s = gca().Children;
    s.AlphaData = alpha.*ones(size(s.XData));
    s.MarkerFaceAlpha = 'flat';
end